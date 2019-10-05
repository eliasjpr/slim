class CreateSubscriptions
  include Clear::Migration

  def change(direction)
    direction.up do
      create_enum("subscrtiption_status", %w(active incomplete trial past_due canceled unpaid in_grace expired))
      create_enum("collection_methods", %w(charge_automatically send_invoice))

      create_table(:subscriptions) do |t|
        t.column :customer_id, "BIGINT", null: false, index: true
        t.column :prorate, "BOOLEAN", null: false, default: true
        t.column :status, :subscrtiption_status, null: false
        t.column :collection_method, :collection_methods, null: false
        t.column :billing_starts_on, "TIMESTAMPTZ", index: true
        t.column :first_bill_on, "TIMESTAMPTZ", index: true
        t.column :ended_at, "TIMESTAMPTZ", index: true
        t.column :trial_start, "TIMESTAMPTZ", index: true
        t.column :trial_end, "TIMESTAMPTZ", index: true

        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
      end
    end

    direction.down do
      drop_enum "subscrtiption_status"
      drop_enum "collection_methods"
    end
  end
end
