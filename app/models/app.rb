class App < ActiveRecord::Base
  belongs_to :language

  has_many :app_resources
  has_many :app_environments
  has_many :app_credentials

end
