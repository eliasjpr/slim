class CreateBalanceTransactions
  include Clear::Migration

  def change(dir)
    dir.up do
      create_enum "balance_transaction_types", %w(adjustment applied_to_invoice credit_note initial invoice_too_small invoice_too_large unspent_receiver_credit)
      create_enum "balance_transaction_status", %w(available pending)

      create_table(:balance_transactionS) do |t|
        t.column :customer_id, "BIGINT", null: false, index: true
        t.column :invoice_id, "BIGINT", null: false, index: true
        t.column :amount, "FLOAT", null: false, default: 0.0
        t.column :ending_balance, "FLOAT", null: false, default: 0.0
        t.column :type, :balance_transaction_types
        t.column :status, :balance_transaction_status
        t.column :currency, "CHAR(3)", null: false, default: "'USD'"
        t.column :description, "VARCHAR(100)"
        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true

        t.references "credit_notes", null: true
      end
    end
  end
end
