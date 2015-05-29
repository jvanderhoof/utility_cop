class AddResourceType < ActiveRecord::Migration
  def change
    add_column :app_environment_resources, :type, :string
  end
end
