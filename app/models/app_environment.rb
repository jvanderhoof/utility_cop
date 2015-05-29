class AppEnvironment < ActiveRecord::Base
  belongs_to :app
  belongs_to :environment

  has_many :app_environment_resources, dependent: :destroy
  has_many :app_environment_credentials, dependent: :destroy

  after_create :set_app_resource_environments

  def app_name_environment
    [app.name, environment.name].join(' ')
  end

  def set_app_resource_environments
    app.app_resources.each do |app_resource|
      app_environment_resources.create(app_environment: self, app_resource: app_resource, count: 0)
    end
  end

end
