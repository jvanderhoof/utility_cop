class AddResourceSettings < ActiveRecord::Migration
  def change
    add_column :app_environment_resources, :settings, :hstore
  end
end
