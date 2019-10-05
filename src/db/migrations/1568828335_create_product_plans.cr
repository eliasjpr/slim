class CreateProductPlans
  include Clear::Migration

  def change(dir)
    dir.up do
      create_table(:product_plans) do |t|
        t.column :amount, "FLOAT", null: false, default: 0.0
        t.column :days, "INTEGER[]", null: true, default: "'{0,1,2,3,4,5,6}'::integer[]"

        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true

        t.references "plans", null: false
        t.references "products", null: false
      end
    end
  end
end
