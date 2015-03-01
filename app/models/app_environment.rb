class AppEnvironment < ActiveRecord::Base
  belongs_to :app
  belongs_to :environment

  has_many :app_environment_resources, dependent: :destroy

  after_create :set_app_resource_environments

  def app_name_environment
    [app.name, environment.name].join(' ')
  end

  def set_app_resource_environments
    app.update_resource_environments
  end
end
