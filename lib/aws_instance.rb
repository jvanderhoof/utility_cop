class AwsInstance < GenericAws

  def new_instance(ami_id, instance_type)
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

end