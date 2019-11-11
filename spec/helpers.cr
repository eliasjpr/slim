def current_time
  (Time.utc - 1.month)
end

def clear
  Clear::SQL.truncate("product_plans", cascade: true)
  Clear::SQL.truncate("subscription_plans", cascade: true)
  Clear::SQL.truncate("subscriptions", cascade: true)
  Clear::SQL.truncate("plans", cascade: true)
  Clear::SQL.truncate("products", cascade: true)
  Clear::SQL.truncate("coupons", cascade: true)
  Clear::SQL.truncate("discounts", cascade: true)
  Clear::SQL.truncate("credit_notes", cascade: true)
  Clear::SQL.truncate("credit_notes", cascade: true)
end

def create_plan(name, cycle : BillingCycles, interval : Int32, usage : UsageTypes, scheme : BillingScheme)
  Plan.create(
    usage_type: usage,
    billing_scheme: scheme,
    billing_cycle: cycle,
    billing_interval: interval,
    trial_period_days: 15,
    name: name,
    description: "",
    amount: 0.00
  )
end

def create_subscription(id, trial_days = 15, bill_cycle = 4.week)
  Subscription.create(
    customer_id: id,
    status: SubscriptionStatus::Active,
    prorate: true,
    collection_method: CollectionMethods::ChargeAutomatically,
    billing_starts_on: current_time + trial_days.days + 1.day,
    first_bill_on: current_time + trial_days.days + 1.day + bill_cycle,
    trial_start: current_time,
    trial_end: current_time + trial_days.days
  )
end

def build_subscription(id = 1, trial_days = 15, bill_cycle = 4.week)
  Subscription.new({
    customer_id:       id,
    status:            SubscriptionStatus::Active,
    prorate:           true,
    collection_method: CollectionMethods::ChargeAutomatically,
    billing_starts_on: current_time + 15.days + 1.day,
    first_bill_on:     current_time + 15.days + 1.day + 4.weeks,
    trial_start:       current_time,
    trial_end:         current_time + 15.days,
  })
end

def create_subscription_plan(subscription, plan, quantity)
  SubscriptionPlan.create(
    plan: plan, subscription: subscription, quantity: quantity
  )
end

def create_product_plan(product, plan, amount, days = [0, 1, 2, 3, 4, 5, 6])
  ProductPlan.create(
    plan: plan, product: product, amount: amount, days: days
  )
end

def create_tier(plan, qty : Int32, amount : Float64)
  Tier.create(
    plan: plan, quantity: qty, amount: amount
  )
end

def create_product(name, code)
  Product.create!(
    title: name,
    active: true,
    code: code,
    caption: nil,
    description: nil,
    attributes: nil,
    deactivate_on: Time.local + 1.year,
    shippable: true,
    kind: ::ProductTypes::HomeDelivery
  )
end

def create_coupon(
  amount = 1.00,
  percent = nil,
  ends_on = current_time + 2.month,
  duration = CouponDuration::Once,
  unit = CouponDurationUnits::Month,
  count = 1,
  redemptions = 10,
  times_redeemed = 0
)
  Coupon.create(
    name: UUID.random.to_s[0..15],
    amount_off: amount,
    percent_off: percent,
    redeem_by: ends_on,
    duration: duration,
    duration_unit: unit,
    duration_count: count,
    max_redemptions: redemptions,
    times_redeemed: times_redeemed
  )
end

def build_coupon(
  amount = 1.00,
  percent = nil,
  ends_on = current_time + 2.month,
  duration = CouponDuration::Once,
  unit = CouponDurationUnits::Month,
  count = 1,
  redemptions = 10,
  times_redeemed = 0
)
  Coupon.new({
    name:            UUID.random.to_s[0..15],
    amount_off:      amount,
    percent_off:     percent,
    redeem_by:       ends_on,
    duration:        duration,
    duration_unit:   unit,
    duration_count:  count,
    max_redemptions: redemptions,
    times_redeemed:  times_redeemed,
  })
end

def create_discount(coupon, subscription, id = 1, starts_on = current_time)
  Discount.create(
    coupon: coupon,
    subscription: subscription,
    customer_id: id,
    starts_on: starts_on
  )
end

def build_discount(coupon, subscription, id = 1, starts_on = 1.month.from_now)
  Discount.new({
    coupon: coupon, subscription: subscription, customer_id: id, starts_on: starts_on,
  })
end

def create_credit_note(id, amount, status = CreditNoteStatus::Issued, created_at = Time.local)
  CreditNote.create(
    amount: amount,
    customer_id: id,
    memo: "Paper not delivered on monday 16",
    reason: CreditNoteReasons::ProductUnsatisfactory,
    status: status,
    kind: CreditNoteTypes::PrePayment,
    created_at: created_at
  )
end
