class CreateVpc
  def perform
    create_default_vpc
  end

  def create_default_vpc
    env = AwsEnvironment.new('Test')
  end
end