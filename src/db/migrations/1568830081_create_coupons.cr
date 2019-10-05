class CreateCoupons
  include Clear::Migration

  def change(dir)
    dir.up do
      create_enum "coupon_duration", %w(forever once repeating)
      create_enum "coupon_duration_units", %w(hour day week month year)

      create_table(:coupons) do |t|
        t.column :name, "VARCHAR(25)", null: false, index: true, unique: true

        t.column :amount_off, "FLOAT", null: true
        t.column :percent_off, "FLOAT", null: true
        t.column :redeem_by, "TIMESTAMPTZ", null: false, index: true
        t.column :duration, :coupon_duration, null: false
        t.column :duration_unit, :coupon_duration_units, null: true
        t.column :duration_count, "INTEGER", null: false, default: 0
        t.column :max_redemptions, "INTEGER", null: false, default: 0
        t.column :times_redeemed, "INTEGER", null: false, default: 0

        t.column :created_at, "TIMESTAMPTZ", index: true, default: "CURRENT_TIMESTAMP"
        t.column :updated_at, "TIMESTAMPTZ", index: true
      end
    end
  end
end
