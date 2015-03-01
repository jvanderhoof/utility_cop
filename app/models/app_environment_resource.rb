class AppEnvironmentResource < ActiveRecord::Base
  belongs_to :app_environment
  belongs_to :app_resource
end
