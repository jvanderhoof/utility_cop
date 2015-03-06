class AppCredential < ActiveRecord::Base
  belongs_to :app
  belongs_to :credential
end
