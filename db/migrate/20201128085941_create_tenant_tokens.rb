class CreateTenantTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tenant_tokens, id: :uuid do |t|
      t.references :tenant, type: :uuid, index: true, null: false
      t.string :token, null: false, index: { unique: true }
      t.boolean :active, null: false, default: false

      t.timestamps
    end
  end
end
