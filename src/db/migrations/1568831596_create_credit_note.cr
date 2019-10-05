class CreateCreditNote
  include Clear::Migration

  def change(dir)
    dir.up do
      create_enum "credit_note_status", %w(issued void)
      create_enum "credit_note_types", %w(post_payment pre_payment)
      create_enum "credit_note_reasons", %w(duplicate fraudulent order_change product_unsatisfactory)

      create_table(:credit_notes) do |t|
        t.column :amount, "FLOAT", null: false, default: 0.0
        t.column :customer_id, "BIGINT", null: false, index: true
        t.column :memo, "VARCHAR(50)"
        t.column :reason, :credit_note_reasons, null: false
        t.column :status, :credit_note_status, null: false
        t.column :type, :credit_note_types, null: false
        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
      end
    end
  end
end
