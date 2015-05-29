class FigTemplate
  class << self
    def web(links)
      %{
  build: .
  command: bin/rails server --port 3000 --binding 0.0.0.0
  ports:
    - \"3000:3000\"
  links:
#{links.map{|i| "\t\t- #{i}"}.join("\n")}
  volumes:
    - .:/app
}
    end

    def redis
      %{
  image: redis:2.8
  ports:
    - \"6379:6379\"
}
    end

    def queue(resources, links)
      %{
  build: .
  command: #{resources.include?(:sidekiq_queue) ? 'sidekiq' : 'bin/resque work'}
  links:
#{links.map{|i| "\t\t- #{i}"}.join("\n")}
  volumes:
    - .:/app
}
    end

    def database(resources)
      if resources.include?(:postgres)
        postgres
      elsif resources.include?(:mysql)
        mysql
      end
    end

    def mysql
      %{
  image: mysql:5.6.23
  ports:
    - "3306:3306"
}
    end

    def postgres
      %{
  image: postgres:9.4.1
  ports:
    - "5432:5432"
}
    end

  end
end

class DockerfileTemplate
  class << self
    def template
      %{
FROM ubuntu:14.04

RUN apt-get update -qq && apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libcurl4-openssl-dev libffi-dev curl <%= @libraries %>

RUN cd /tmp; \\
curl -O http://cache.ruby-lang.org/pub/ruby/<%= @ruby_family %>/ruby-<%= @ruby_version %>.tar.gz; \\
sudo chown default: *.tar.gz; \\
tar xvzf *.tar.gz; rm -f *.tar.gz; \
cd ruby*; \\
./configure; \\
make; \\
make install; \\
cd; \\
rm -rf /tmp/ruby*

RUN gem install bundler pry --no-rdoc --no-ri

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
}
    end
  end
end

class DockerfileBuilder
  class << self
    def from_file(file_path)
      from_string(IO.read(file_path))
    end

    def from_string(str)
      ruby_version = str.match(/ruby ['|"]([\d.]+)['|"]/)[1]
      ruby_family = ruby_version.match(/^(\d\.\d)/)[1]
      dependencies = get_dependencies(Gemnasium::Parser.gemfile(str).dependencies.map(&:name))
      puts dependencies.inspect
      build_files(ruby_version, ruby_family, dependencies)
    end

    def build_files(ruby_version, ruby_family, dependencies)
      build_dockerfile(ruby_version, ruby_family, dependencies[:libraries].join(' '))
      build_fig(dependencies[:resources])
    end

    def build_fig(resources)
      links = []
      config = {}

      if resources.any?{|resource| [:mysql, :postgres].include?(resource)}
        config[:db] = FigTemplate.database(resources)
        links << 'db'
      end
      if resources.include?(:redis)
        config[:redis] = FigTemplate.redis
        links << 'redis'
      end
      if resources.any?{|resource| [:sidekiq_queue, :resque_queue].include?(resource)}
        config[:queue] = FigTemplate.queue(resources, links)
      end

      config[:web] = FigTemplate.web(links)

      File.open('docker-compose-test.yml', 'w+') do |f|
        config.each do |key, value|
          f.write("#{key}:#{value}\n")
        end
      end
    end

    def build_dockerfile(ruby_version, ruby_family, libraries)
      puts libraries.inspect
      @ruby_version, @ruby_family, @libraries = ruby_version, ruby_family, libraries
      puts @libraries.inspect
      File.open('Dockerfile-test', "w+") do |f|
        f.write(ERB.new(DockerfileTemplate.template).result(binding))
      end
    end

    def get_dependencies(gems)
      gems.each_with_object({resources: [], libraries: []}) do |gem_name, hsh|
        case gem_name
        when 'pg'
          hsh[:libraries] << 'libpq-dev'
          hsh[:resources] << :postgres
        when 'mysql2'
          hsh[:libraries] << 'libmysqlclient-dev'
          hsh[:resources] << :mysql
        when 'coffee-script', 'coffee-rails'
          hsh[:libraries] << 'nodejs'
        when 'nokogiri', 'rails'
          hsh[:libraries] << 'libxml2-dev libxslt1-dev'
        when 'sidekiq', 'resque', 'redis'
          hsh[:resources] << :redis
          hsh[:resources] << "#{gem_name}_queue".to_sym unless gem_name == 'redis'
        when 'capybara-webkit'
          hsh[:libraries] << 'libqt4-webkit libqt4-dev xvfb'
        end
      end
    end
  end
end


namespace :play do
  task :vpcs, [:environment] do
    puts AwsEnvironment.vpcs.inspect
  end

  task :packer_test, [:environment] do
    BuildPackerAmi.new('ruby-2.2.json').process
  end

  task :test, [:environment] do
    env = AwsEnvironment.new('GZ')
    puts env.vpc_scoped_name_filters('test').inspect
  end

  task :parse_gems, [:environment] do
    DockerfileBuilder.from_file('Gemfile-test')
    #s = IO.read('Gemfile')
    #ruby_version = s.match(/ruby ['|"]([\d.]+)['|"]/)[1]
    #puts "ruby version: #{ruby_version}"
    #gems = Gemnasium::Parser.gemfile(s).dependencies.map(&:name)
    #puts "gems: #{gems.inspect}"
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