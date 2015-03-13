class AwsEnvironment
  attr_accessor :prefix

  def initialize(prefix)
    self.prefix = prefix
    route_table
  end

  def vpc
    vpc_name = "#{prefix}-Default"
    @vpc ||= begin
      vpc_struct = ec2_client.describe_vpcs(filters: name_search_filters(vpc_name)).vpcs.first
      if vpc_struct
        aws_object_from_id('Vpc', vpc_struct.vpc_id)
      else
        vpc_struct = ec2_client.create_vpc(cidr_block: "10.0.0.0/16")
        puts vpc_struct.inspect
        vpc_obj = aws_object_from_id('Vpc', vpc_struct.vpc.vpc_id)
        vpc_obj.create_tags(tags: name_tags(vpc_name))
        [:enable_dns_support, :enable_dns_hostnames].each do |key|
          vpc_obj.modify_attribute(key => {value: true})
        end
        vpc_obj
      end
    end
  end

  def subnet
    subnet_name = "#{prefix} Public Subnet"
    @subnet ||= begin
      subnet_struct = ec2_client.describe_subnets(filters: vpc_scoped_name_filters(subnet_name)).subnets.first
      if subnet_struct
        aws_object_from_id('Subnet', subnet_struct.subnet_id)
      else
        subnet = vpc.create_subnet(cidr_block: "10.0.0.0/24", availability_zone: 'us-east-1e')
        subnet.create_tags(tags: name_tags(subnet_name))
        subnet
      end
    end
  end

  def gateway
    gateway_name = "#{prefix}-Default-Gateway"
    @gateway ||= begin
      gateway_struct = ec2_client.describe_internet_gateways(filters: [{name: 'attachment.vpc-id', values: [vpc.id]}]).internet_gateways.first
      if gateway_struct
        aws_object_from_id('InternetGateway', gateway_struct.internet_gateway_id)
      else
        internet_gateway = ec2_client.create_internet_gateway.internet_gateway
        vpc.attach_internet_gateway(internet_gateway_id: internet_gateway.internet_gateway_id)
        ig = aws_object_from_id('InternetGateway', internet_gateway.internet_gateway_id)
        ig.create_tags(tags: name_tags(gateway_name))
        ig
      end
    end
  end

  def route_table
    route_table_name = "#{prefix}-Route-Table"
    @route_table ||= begin
      route_table_struct = ec2_client.describe_route_tables(filters: vpc_scoped_name_filters(route_table_name)).route_tables.first
      if route_table_struct
        aws_object_from_id('RouteTable', route_table_struct.route_table_id)
      else
        route_table = vpc.create_route_table
        route_table.create_tags(tags: name_tags(route_table_name))
        route_table.associate_with_subnet(subnet_id: subnet.id)
        route_table.create_route(destination_cidr_block: '0.0.0.0/0', gateway_id: gateway.id)
        route_table
      end
    end
  end

  #private

    def aws_object_from_id(resource_type, resource_id)
      "Aws::EC2::#{resource_type}".constantize.new(resource_id, client: ec2_client)
    end

    def time_this(msg)
      start_time = Time.now
      yield
      puts "#{msg} took: #{Time.now - start_time}"
    end

    def credentials
      @creds ||= Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_ACCESS_KEY'])
    end

    def ec2_client
      @ec2_client ||= Aws::EC2::Client.new(region: 'us-east-1', credentials: credentials)
    end

    def vpc_scoped_name_filters(name)
      name_search_filters(name).push({name: 'vpc-id', values: [vpc.id]})
    end

    def name_search_filters(name)
      [
        {name: 'tag-key', values: ['Name']},
        {name: 'tag-value', values:[name]}
      ]
    end

  def name_tags(name)
    [{key: 'Name', value: name}]
  end



end

namespace :test do
  task :test, [:environment] do
    env = AwsEnvironment.new('GZ')
    puts env.vpc_scoped_name_filters('test').inspect
  end

=begin
  end

  def name_resource(resource_id, name)
    ec2_client.create_tags(resources: [resource_id], tags: [{key: 'Name', value: name}])
  end



  def build_and_configure_vpc
    vpc
    subnet
    gateway


  end



  def route_table
    route_table = vpc.create_route_table
    route_table.create_tags(tags: name_tags('GZ-Route-Table'))

    subnet = ec2_client.describe_subnets(filters: name_filter('GZ Public Subnet')).subnets.first
    route_table.associate_with_subnet(subnet_id: subnet.subnet_id)

    route_table.create_route(destination_cidr_block: '0.0.0.0/0', gateway_id: vpc.internet_gateways.first.internet_gateway_id)
  end



  def find_or_create_gateway(vpc_id)
    ec2_client.describe_internet_gateways(filters: [{name: 'attachment.vpc-id', values: [vpc_id]}]).internet_gateways.first || begin
      internet_gateway = ec2_client.create_internet_gateway.internet_gateway
      ec2_client.attach_internet_gateway(internet_gateway_id: internet_gateway.internet_gateway_id, vpc_id: vpc_id)
      name_resource(internet_gateway.internet_gateway_id, 'GZ-Default-Gateway')
      internet_gateway
    end
  end

  def find_or_create_vpc(name)
    ec2_client.describe_vpcs(filters: name_filter(name)).vpcs.first || begin
      resp = ec2_client.create_vpc(cidr_block: "10.0.0.0/16", )
      name_resource(resp.vpc.vpc_id, name)

      # enable dns support & hostnames
      [:enable_dns_support, :enable_dns_hostnames].each do |key|
        ec2_client.modify_vpc_attribute(vpc_id: resp.vpc.vpc_id, key.to_sym => {value: true})
      end

      resp.vpc
    end
  end

  #task :internet_gateways, [:environment] do
  #  vpc = Aws::EC2::Vpc.new(find_or_create_vpc('GZ-Default').vpc_id, client: ec2_client).in
  #  vpc.internet_gateways.each do |internet_gateway|
  #    puts internet_gateway.inspect
  #  end
  #end

  def launch_instance
    resp = ec2_client.run_instances(
      image_id: 'ami-b46439dc',
      min_count: 1,
      max_count: 1,
      key_name: 'aws-2015-01-21',
      instance_type: 't1.micro',
      network_interfaces: [{
        device_index: 0,
        associate_public_ip_address: true,
        subnet_id: ec2_client.describe_subnets(filters: name_filter('GZ Public Subnet')).subnets.first.subnet_id,
        groups: ['sg-53841237']
      }]
    )
    puts "launched....."

    ec2_client.wait_until(:instance_running, instance_ids: resp.instances.map(&:instance_id))

    resp.instances.map(&:instance_id).each do |instance_id|
      puts "instance: #{instance_id}"
      instance = Aws::EC2::Instance.new(instance_id, client: ec2_client)
      puts " -- (#{instance.id}) #{instance.public_ip_address}"
    end
  end

  def ssh_access_security_group
    name = 'default-ssh-3'
    sg = vpc.security_groups.find{|i| i.group_name == name}
    return sg unless sg.nil?
    sg = vpc.create_security_group(group_name: name, description: 'expose ssh port')
    sg = Aws::EC2::SecurityGroup.new(sg.id, client: ec2_client)
    sg.authorize_ingress(ip_permissions: [{
            ip_protocol: 'tcp',
            from_port: 22,
            to_port: 22,
            ip_ranges: [
              {cidr_ip: '0.0.0.0/0'}
            ]
          }]
        )
    sg
  end
=end

  task :security_group, [:environment] do
    puts ssh_access_security_group.inspect
  end

  task :new_instance, [:environment] do
    launch_instance
  end

  task :route_table, [:environment] do
    route_table = vpc.create_route_table
    route_table.create_tags(tags: name_tags('GZ-Route-Table'))

    subnet = ec2_client.describe_subnets(filters: name_filter('GZ Public Subnet')).subnets.first
    route_table.associate_with_subnet(subnet_id: subnet.subnet_id)

    route_table.create_route(destination_cidr_block: '0.0.0.0/0', gateway_id: vpc.internet_gateways.first.internet_gateway_id)
  end

  task :name_gateway, [:environment] do
    vpc = find_or_create_vpc('GZ-Default')
    internet_gateway = find_or_create_gateway(vpc.vpc_id)
    name_resource(internet_gateway.internet_gateway_id, 'GZ-Default-Gateway')
  end

  task :gateway, [:environment] do
    vpc = find_or_create_vpc('GZ-Default')
    find_or_create_gateway(vpc.vpc_id)
  end


  task :vpc, [:environment] do
    #vpc = find_or_create_vpc('GZ-Default')
    env = AwsEnvironment.new('GZ')
    #puts vpc.inspect
  end

  task :subnet, [:environment] do
    vpc = find_or_create_vpc('GZ-Default')
    subnet = find_or_create_subnet(vpc.vpc_id, 'GZ Public Subnet')
    puts subnet.inspect
  end

  task :images, [:environment] do
    time_this 'load images' do
      connection.images.all('is-public' => 'false')
          .select{|i| i.tags['language_and_version'] == 'ruby-2.2.0'}
          .sort{|x,y| y.location <=> x.location}
          .each do |image|
        puts "image: #{image.id} -> #{image.location}"
      end
    end
  end

  task :connection, [:environment] do
    #puts connection.inspect
    time_this 'load images' do
      connection.images.all('is-public' => 'false').map do |image|
        puts "image: #{image.id} -> #{image.tags.inspect}"
      end
    end
    #puts connection.servers.first.inspect
    #connection.servers.each_with_index do |server, index|
    #  puts "#{index}) #{server.id}"
    #end
=begin
    credentials, client, resource = nil, nil, nil
    time_this 'credentials' do
      credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_ACCESS_KEY'])
    end
    time_this 'client' do
      client = Aws::EC2::Client.new(
              region: 'us-east-1',
              credentials: credentials
            )
    end
    #puts client.resource.first.inspect
    time_this 'resource' do
      resource = Aws::EC2::Resource.new(client: client)
    end
    #puts resource.first.inspect
    time_this('total time') do
      resource.images.limit(5).each do |image|
        time_this('image time') do
          puts image.inspect
        end
      end
    end
    #puts ENV['AWS_ACCESS_KEY']
    #ec
=end
  end
end