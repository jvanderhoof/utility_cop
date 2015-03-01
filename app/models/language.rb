class Language < ActiveRecord::Base
  has_many :resources
  has_many :apps

  default_scope { order(:name) }

end
