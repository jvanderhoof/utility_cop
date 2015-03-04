class AddAmiIdToResourceAndAppResource < ActiveRecord::Migration
  def change
    add_column :resources, :ami_id, :string
    add_column :app_resources, :ami_id, :string
  end
end
