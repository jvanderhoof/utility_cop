class CreateElb
  def perform
    create_elb
  end

  def create_elb
    env = AwsEnvironment.new('Test')
    vpc = env.vpc
  end
end