Clear.enum CouponDuration, :forever, :once, :repeating
Clear.enum CouponDurationUnits, :hour, :day, :week, :month, :year

class Coupon
  include Clear::Model

  column id : Int64, primary: true, presence: false
  column name : String

  column amount_off : Float64?
  column percent_off : Float64?

  column redeem_by : Time # Date after which the coupon can no longer be redeemed.
  column duration : CouponDuration
  column duration_unit : CouponDurationUnits
  column duration_count : Int64

  column max_redemptions : Int64 # Maximum number of times this coupon can be redeemed, in total, across all customers, before it is no longer valid.
  column times_redeemed : Int64  # Number of times this coupon has been applied to a customer.

  def redeem!
    redemptions = times_redeemed + 1
    Coupon.query.where(id: id).to_update.set(times_redeemed: redemptions).execute
    reload
  end

  def deduction_for(charges : Float64) : Float64
    return amount_off.not_nil! unless amount_off.nil?
    return (charges * percent_off.not_nil!) unless percent_off.nil?
    0.00
  end

  def applicable?
    redeem_by >= Time.local
  end

  def redeemable?
    times_redeemed < max_redemptions
  end

  def time_span
    case duration_unit
    when CouponDurationUnits::Hour  then duration_count.hour
    when CouponDurationUnits::Day   then duration_count.day
    when CouponDurationUnits::Week  then duration_count.week
    when CouponDurationUnits::Month then duration_count.month
    when CouponDurationUnits::Year  then duration_count.year
    else
      raise "Unsupported Coupon Duration Units!"
    end
  end
end
