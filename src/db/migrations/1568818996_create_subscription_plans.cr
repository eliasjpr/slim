class CreateSubscriptionPlans
  include Clear::Migration

  def change(dir)
    dir.up do
      create_table(:subscription_plans) do |t|
        t.column :quantity, "INTEGER", null: false, default: 0
        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
        t.references "plans", null: false
        t.references "subscriptions", null: false
      end
    end

    dir.down do
    end
  end
end
