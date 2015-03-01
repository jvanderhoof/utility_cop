class AppResource < ActiveRecord::Base
  belongs_to :app
  belongs_to :resource

  has_many :app_environment_resources, dependent: :destroy

  after_create :set_app_resource_environments

  def set_app_resource_environments
    app.update_resource_environments
  end
end
