class AddAppCredentialKey < ActiveRecord::Migration
  def change
    add_column :app_credentials, :key, :string
    add_column :app_environment_credentials, :app_credential_id, :integer
  end
end
