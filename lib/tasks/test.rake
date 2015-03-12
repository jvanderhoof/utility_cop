namespace :test do

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

  def ec2_resource
    @ec2_resource ||= Aws::EC2::Resource.new(region: 'us-east-1', credentials: credentials)
  end

  def find_or_create_subnet(vpc_id, name, availability_zone='us-east-1e')
    ec2_client.describe_subnets(filters: name_filter(name)).subnets.first || begin
      resp = ec2_client.create_subnet(vpc_id: vpc_id, cidr_block: "10.0.0.0/24", availability_zone: availability_zone)
      name_resource(resp.subnet.subnet_id, name)
      resp.subnet
    end
  end

  def find_or_create_gateway(vpc_id)
    ec2_client.describe_internet_gateways(filters: [{name: 'attachment.vpc-id', values: [vpc_id]}]).internet_gateways.first || begin
      internet_gateway = ec2_client.create_internet_gateway.internet_gateway
      ec2_client.attach_internet_gateway(internet_gateway_id: internet_gateway.internet_gateway_id, vpc_id: vpc_id)
    end
  end

  def name_resource(resource_id, name)
    ec2_client.create_tags(resources: [resource_id], tags: [{key: 'Name', value: name}])
  end

  def name_filter(name)
    [
      {name: 'tag-key', values: ['Name']},
      {name: 'tag-value', values:[name]}
    ]
  end

  def launch_instance
    #ec2_resource.
  end

  def find_or_create_vpc(name)
    ec2_client.describe_vpcs(filters: name_filter(name)).vpcs.first || begin
      resp = ec2_client.create_vpc(cidr_block: "10.0.0.0/16", )
      name_resource(resp.vpc.vpc_id, name)
      resp.vpc
      ec2_client.modify_vpc_attribute(
                          vpc_id: resp.vpc.vpc_id,
                          enable_dns_support: { value: true },
                          enable_dns_hostnames: { value: true },
                        )
    end
  end

  task :update_vpc, [:environment] do
    vpc = find_or_create_vpc('GZ-Default')
    #vpc.modify_attribute(enable_dns_support: { value: true },
    #                      enable_dns_hostnames: { value: true })

    [:enable_dns_support, :enable_dns_hostnames].each do |key|
      ec2_client.modify_vpc_attribute(vpc_id: vpc.vpc_id, key.to_sym => {value: true})
    end
      #                    vpc_id: vpc.vpc_id,
      #                    enable_dns_support: { value: true },
      #                    enable_dns_hostnames: { value: true }
      #                  )
  end

  task :gateway, [:environment] do
    vpc = find_or_create_vpc('GZ-Default')
    find_or_create_gateway(vpc.vpc_id)
  end


  task :vpc, [:environment] do
    vpc = find_or_create_vpc('GZ-Default')
    puts vpc.inspect
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