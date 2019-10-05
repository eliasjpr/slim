class CreateTiers
  include Clear::Migration

  def change(dir)
    dir.up do
      create_table(:tiers) do |t|
        t.column :quantity, "INTEGER", null: false, default: 0
        t.column :amount, "FLOAT", null: false, default: 0.0

        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true

        t.references "plans", null: false
      end
    end
  end
end
