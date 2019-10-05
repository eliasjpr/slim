class CreatePlans
  include Clear::Migration

  def change(direction)
    direction.up do
      create_enum "billing_cycles", %w(hour day week month year)
      create_enum "usage_types", %w(licensed metered)
      create_enum "billing_scheme", %w(tiered per_unit)

      create_table(:plans) do |t|
        t.column :usage_type, :usage_types, null: false
        t.column :billing_scheme, :billing_scheme, null: false
        t.column :billing_cycle, :billing_cycles, null: false
        t.column :billing_interval, "INTEGER", null: false, default: 0
        t.column :trial_period_days, "INTEGER", null: true
        t.column :name, "VARCHAR(50)", null: false, index: true, unique: true
        t.column :description, "VARCHAR(100)", null: true
        t.column :amount, "FLOAT", null: false, default: 0.0

        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
      end
    end

    direction.down do
      drop_enum "billing_cycles"
      drop_enum "usage_types"
      drop_enum "billing_scheme"
    end
  end
end
