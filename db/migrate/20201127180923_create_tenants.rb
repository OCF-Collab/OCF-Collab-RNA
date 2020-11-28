class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants, id: :uuid do |t|
      t.string :name, null: false
      t.string :oauth_client_id, null: false, index: { unique: true }
      t.string :oauth_client_secret, null: false

      t.timestamps
    end
  end
end
