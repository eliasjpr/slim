require "json"

class Bill
  include JSON::Serializable
  @[JSON::Field(ignore: true)]
  @billing_start_date : Time
  @[JSON::Field(ignore: true)]
  @billing_end_date : Time

  @[JSON::Field(ignore: true)]
  @subscription : Subscription

  @[JSON::Field(ignore: true)]
  getter subscription_plan : SubscriptionPlan
  getter plan : Plan

  getter billing_period : BillingPeriod
  getter total : Float64 = 0.0
  getter subtotal : Float64 = 0.0
  getter discounts : Float64 = 0.0
  getter charges : Float64 = 0.0
  getter credits : Float64 = 0.0
  getter amount_paid : Float64 = 0.0
  getter amount_remaining : Float64 = 0.0
  getter usage : Int64 = 0
  getter tax : Float64 = 0.0
  getter starting_balance = 0.0
  getter amount_due : Float64 = 0.0
  getter due_date : Time = Time.local + 3.days

  def initialize(@subscription_plan, @billing_start_date : Time)
    @plan = subscription_plan.plan
    @subscription = subscription_plan.subscription
    @billing_end_date = @billing_start_date + plan.bill_cycle
    @billing_period = BillingPeriod.new(@billing_start_date, @billing_end_date)
    amount_remaining
  end

  def amount_remaining
    @amount_remaining ||= amount_due - amount_paid
  end

  def amount_due
    @amount_due ||= (total).round(2)
  end

  def total
    @total ||= subtotal + (subtotal * tax) - (discounts)
  end

  def subtotal
    @subtotal ||= (charges - credits).round(2)
  end

  def discounts
    @discounts ||= @subscription.discounts.to_a.reduce(0.0) { |acc, discount| acc += discount.amount_for(charges) }
  end

  def charges
    @charges ||= plan.cost(billing_period).round(2)
  end

  def credits
    @credits ||= CreditNote.credits_for(
      customer_id, @billing_start_date, @billing_end_date.at_end_of_day
    )
  end

  def starting_balance
    @starting_balance = 0.0
  end

  def amount_paid
    @amount_paid = 0.0
  end
  
  def tax
    @tax = 0.0
  end

  private def customer_id
    subscription_plan.subscription.customer_id.to_i32
  end
end
