require "json"

class SubscriptionPlan
  include JSON::Serializable
  include Clear::Model

  belongs_to plan : Plan
  belongs_to subscription : Subscription

  column id : Int64, primary: true, presence: false
  column quantity : Int64

  def invoice(billing_start_date : Time)
    Bill.new(self, billing_start_date)
  end
end
