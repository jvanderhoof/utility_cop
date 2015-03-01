class CreateAppEnvironmentResources < ActiveRecord::Migration
  def change
    create_table :app_environment_resources do |t|
      t.references :app_environment, index: true
      t.references :app_resource, index: true
      t.integer :count
      t.string :ami_id

      t.timestamps null: false
    end
    add_foreign_key :app_environment_resources, :app_environments
    add_foreign_key :app_environment_resources, :app_resources
  end
end
