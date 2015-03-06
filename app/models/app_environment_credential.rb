class AppEnvironmentCredential < ActiveRecord::Base
  belongs_to :app_environment
  belongs_to :credential
end
