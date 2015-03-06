class Credential < ActiveRecord::Base
  has_many :app_credentials
  has_many :app_environment_credentials

end
