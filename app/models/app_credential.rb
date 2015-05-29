class AppCredential < ActiveRecord::Base
  belongs_to :app
  #belongs_to :credential
  has_many :app_environment_credentials, dependent: :destroy

  after_create :set_app_credential_environments

  def set_app_credential_environments
    app.app_environments.each do |app_environment|
      app_environment_credentials.create(app_credential: self, app_environment: app_environment)
    end
  end

end
