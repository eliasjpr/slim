require "./pricing/*"

Clear.enum BillingScheme, :tiered, :per_unit
Clear.enum BillingCycles, :hour, :day, :week, :month, :year
Clear.enum UsageTypes, :licensed, :metered, :graduated, :volume

class Plan
  include Clear::Model

  has_many subscriptions : Subscription, through: :subscription_plans
  has_many products : Subscription, through: :product_plans
  has_many product_plans : ProductPlan
  has_many tiers : Tiers

  column id : Int64, primary: true, presence: false
  column usage_type : UsageTypes
  column billing_scheme : BillingScheme
  column billing_cycle : BillingCycles
  column billing_interval : Int32
  column trial_period_days : Int32
  column name : String
  column description : String
  column amount : Float64

  def bill_cycle
    case billing_cycle
    when BillingCycles::Hour  then billing_interval.hour
    when BillingCycles::Day   then billing_interval.day
    when BillingCycles::Week  then billing_interval.week
    when BillingCycles::Month then billing_interval.month
    when BillingCycles::Year  then billing_interval.year
    else
      raise "Unsupported Billing Cycle!"
    end
  end
end
