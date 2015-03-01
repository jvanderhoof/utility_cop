class Resource < ActiveRecord::Base
  belongs_to :language

  has_many :app_resources
  has_many :resource_builds
end
