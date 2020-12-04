class AddDefaultToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :default, :boolean, null: false, default: false
  end
end
