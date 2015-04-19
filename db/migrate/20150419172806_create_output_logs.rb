class CreateOutputLogs < ActiveRecord::Migration
  def change
    create_table :output_logs do |t|
      t.string :name
      t.text :log, default: ''
      t.string :error
      t.text :stacktrace

      t.timestamps null: false
    end
  end
end
