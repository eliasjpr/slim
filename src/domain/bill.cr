require "json"

class Bill
  include JSON::Serializable

  @[JSON::Field(ignore: true)]
  getter subscription : Subscription

  @[JSON::Field(ignore: true)]
  property subscription_plan : SubscriptionPlan
  property plan : Plan
  property usage : Int64 = 0
  property billing_period : BillingPeriod
  property subtotal : Float64
  property discounts : Float64
  property charges : Float64
  property credits : Float64
  property amount_paid : Float64 = 0
  property amount_remaining : Float64
  property tax : Float64 = 0.0
  property starting_balance
  property amount_due : Float64
  property due_date : Time = Time.local + 3.days

  def initialize(@subscription_plan, billing_start_date : Time)
    @plan = subscription_plan.plan
    @subscription = subscription_plan.subscription
    @billing_period = BillingPeriod.new(billing_start_date, plan.bill_cycle)
    @credits = CreditNote.credits_for(@subscription.customer_id, billing_period).round(2)
    @charges = Pricing.cost(billing_period, plan).round(2)
    @discounts = @subscription.total_discounts(charges).round(2)
    @subtotal = (charges - credits).round(2)
    @amount_due = (subtotal + (subtotal * tax) - (discounts)).round(2)
    @amount_remaining = (amount_due - amount_paid).round(2)
  end
end
