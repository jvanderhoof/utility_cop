class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :value
      t.integer :app_id

      t.timestamps null: false
    end

    add_index :settings, :app_id
  end
end
