require "../spec_helper"

module Operations::Subscriptions
  describe Invoices do
    subscription_id = 1
    start_date = Time.parse("09-01-2019", "%m-%d-%Y", Time::Location::UTC)
    subject = call(subscription_id, start_date)

    describe "#call" do
      it "returns a list of invoices"
    end
  end
end
