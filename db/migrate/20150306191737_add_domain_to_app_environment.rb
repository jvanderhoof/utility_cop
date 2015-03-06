class AddDomainToAppEnvironment < ActiveRecord::Migration
  def change
    add_column :app_environments, :domain, :string
  end
end
