class CreateAppEnvironmentCredentials < ActiveRecord::Migration
  def change
    create_table :app_environment_credentials do |t|
      t.integer :credential_id
      t.integer :app_environment_id
      t.string :encrypted_value
      t.string :text_value

      t.timestamps null: false
    end
  end
end
