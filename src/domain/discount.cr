class Discount
  include Clear::Model

  belongs_to coupon : Coupon
  belongs_to subscription : Subscription

  column id : Int64, primary: true, presence: false
  column customer_id : Int64
  column starts_on : Time
  column created_at : Time, presence: false

  delegate applicable?, to: coupon
  delegate redeem!, to: coupon
  delegate redeemable?, to: coupon
  delegate time_span, to: coupon

  def amount_for(subtotal : Float64)
    return 0.0 unless valid?

    amount = case coupon.duration
             when CouponDuration::Forever then coupon.deduction_for(subtotal)
             when CouponDuration::Once
               if coupon.times_redeemed < 1
                 coupon.deduction_for(subtotal)
               end
             when CouponDuration::Repeating then coupon.deduction_for(subtotal)
             else
               0.00
             end

    amount || 0.00
  end

  def validate
    add_error "expired", "Discount expired!" if expired?
    add_error "coupon", "Coupon expired!" unless applicable?
    add_error "coupon", "Coupon cannot be redeemed!" unless redeemable?
  end

  def expired?
    ends_on < Time.local
  end

  private def ends_on
    starts_on + time_span
  end
end
