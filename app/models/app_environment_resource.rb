class AppEnvironmentResource < ActiveRecord::Base
  belongs_to :app_environment
  belongs_to :app_resource

  def name
    [
      app_environment.app_name_environment,
      app_resource.resource.name
    ].join(' ')
  end
end
