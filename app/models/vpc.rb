class Vpc #< ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessor :name, :vpc_id

  def save
    AwsEnvironment.new(self.name)
    true
  end

  class << self

    def all
      self.ec2_client.describe_vpcs.vpcs
    end

    protected
      def credentials
        @creds ||= Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      end

      def ec2_client
        @ec2_client ||= Aws::EC2::Client.new(region: 'us-east-1', credentials: credentials)
      end
  end
end
