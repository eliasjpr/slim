class CreateProducs
  include Clear::Migration

  def change(dir)
    dir.up do
      create_enum "product_types", %w(home_delivery digital)

      create_table(:products) do |t|
        t.column :active, "BOOLEAN", null: false, default: false
        t.column :title, "VARCHAR(50)", null: false, index: true, unique: true
        t.column :code, "VARCHAR(10)", null: false, index: true, unique: true
        t.column :caption, "VARCHAR(100)"
        t.column :description, "VARCHAR(150)"
        t.column :attributes, "JSONB"
        t.column :deactivate_on, "TIMESTAMPTZ"
        t.column :shippable, "BOOLEAN", null: false, default: false
        t.column :type, :product_types, null: false

        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
      end
    end
  end
end
