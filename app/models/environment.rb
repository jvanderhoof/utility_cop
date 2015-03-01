class Environment < ActiveRecord::Base
  has_many :app_environments, dependent: :destroy
end
