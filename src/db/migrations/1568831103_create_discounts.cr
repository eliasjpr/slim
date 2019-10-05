class CreateDiscounts
  include Clear::Migration

  def change(dir)
    dir.up do
      create_table(:discounts) do |t|
        t.references "subscriptions", null: false
        t.references "coupons", null: false
        t.column :customer_id, "BIGINT", null: false, index: true, unique: true
        t.column :starts_on, "TIMESTAMPTZ", null: false, index: true
        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
      end
    end
  end
end
