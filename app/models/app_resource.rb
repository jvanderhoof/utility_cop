class AppResource < ActiveRecord::Base
  belongs_to :app
  belongs_to :resource

  has_many :app_environment_resources
end
