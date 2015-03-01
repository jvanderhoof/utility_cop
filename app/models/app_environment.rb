class AppEnvironment < ActiveRecord::Base
  belongs_to :app
  belongs_to :environment

  has_many :app_environment_resources
end
