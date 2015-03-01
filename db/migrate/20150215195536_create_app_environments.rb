class CreateAppEnvironments < ActiveRecord::Migration
  def change
    create_table :app_environments do |t|
      t.references :app, index: true
      t.references :environment, index: true
      t.string :git_tag

      t.timestamps null: false
    end
    add_foreign_key :app_environments, :apps
    add_foreign_key :app_environments, :environments
  end
end
