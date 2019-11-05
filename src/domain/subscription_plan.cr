require "json"

class SubscriptionPlan
  include JSON::Serializable
  include Clear::Model

  belongs_to plan : Plan
  belongs_to subscription : Subscription

  column id : Int64, primary: true, presence: false
  column quantity : Int64

  def self.invoice_for(subscription_id : Int64, billing_start_date : Time)
    SubscriptionPlan.query
      .where(subscription_id: subscription_id)
      .map { |sp| Bill.new(sp, billing_start_date) }
  end
end
