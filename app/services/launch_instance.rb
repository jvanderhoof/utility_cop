class LaunchInstance
  attr_accessor :ami_id, :tags

  def initialize(ami_id, app_name, app_environment, resource_name)
    self.ami_id = ami_id
    self.tags = [
      {
        name: app_name,
        environment: app_environment,
        resource_type: resource_name
      }
    ]
  end

  def launch(ami_id, tags)

  end
end