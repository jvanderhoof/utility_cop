class AwsEnvironment < GenericAws

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
        subnet = vpc.create_subnet(cidr_block: "10.0.0.0/26", availability_zone: 'us-east-1e')
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

end
