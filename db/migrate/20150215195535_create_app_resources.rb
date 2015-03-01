class CreateAppResources < ActiveRecord::Migration
  def change
    create_table :app_resources do |t|
      t.references :app, index: true
      t.references :resource, index: true

      t.timestamps null: false
    end
    add_foreign_key :app_resources, :apps
    add_foreign_key :app_resources, :resources
  end
end
