class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :cookbook_url
      t.references :language, index: true

      t.timestamps null: false
    end
    add_foreign_key :resources, :languages
  end
end
