Clear.enum CollectionMethods, :charge_automatically, :send_invoice
Clear.enum SubscriptionStatus, :active, :incomplete, :trial, :past_due, :canceled, :unpaid, :in_grace, :expired

class Subscription
  include Clear::Model

  has_many plans : Plan, through: :subscription_plans
  has_many subscription_plans : SubscriptionPlan
  has_many discounts : Discount

  column id : Int64, primary: true, presence: false
  column customer_id : Int64
  column prorate : Bool = true
  column status : SubscriptionStatus
  column collection_method : CollectionMethods
  column billing_starts_on : Time
  column first_bill_on : Time
  column ended_at : Time?
  column trial_start : Time?
  column trial_end : Time?

  def invoices(billing_start_date : Time)
    subscription_plans.map do |sp|
      sp.invoice(billing_start_date)
    end
  end

  def total_discounts
    @total_discounts ||= discounts.to_a.reduce(0.0) { |acc, discount| acc += discount.amount_for(charges) }
  end
end
