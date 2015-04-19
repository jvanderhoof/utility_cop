class Resource < ActiveRecord::Base
  belongs_to :language

  has_many :app_resources, dependent: :destroy
  has_many :resource_builds

  default_scope { order(:name) }

  def ami
    ami_id
  end
end
