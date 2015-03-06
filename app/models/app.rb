class App < ActiveRecord::Base
  belongs_to :language

  has_many :app_resources
  has_many :app_environments
  has_many :app_credentials

  def current_resource_environments
    AppEnvironmentResource.where(["app_resource_id in (?) or app_environment_id in (?)",
      app_resources.map(&:id),
      app_environments.map(&:id)
    ]).map{|i| "#{i.app_resource_id}-#{i.app_environment_id}"}
  end

  def update_resource_environments
    current_resource_environment_list = current_resource_environments
    app_resources.each do |resource|
      app_environments.each do |environment|
        next if current_resource_environment_list.include?("#{resource.id}-#{environment.id}")
        AppEnvironmentResource.create(
          app_resource_id: resource.id,
          app_environment_id: environment.id,
          count: 0
        )
      end
    end
  end
end
