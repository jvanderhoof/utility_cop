class AddInstanceTypeToAppEnvironment < ActiveRecord::Migration
  def change
    add_column :app_environment_resources, :instance_type, :string
  end
end
