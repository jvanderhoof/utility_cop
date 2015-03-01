class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :git_repo
      t.references :language, index: true

      t.timestamps null: false
    end
    add_foreign_key :apps, :languages
  end
end
