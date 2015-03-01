class CreateResourceBuilds < ActiveRecord::Migration
  def change
    create_table :resource_builds do |t|
      t.references :resource, index: true
      t.string :cookbook_version
      t.string :git_tag
      t.string :ami_id
      t.boolean :current

      t.timestamps null: false
    end
    add_foreign_key :resource_builds, :resources
  end
end
