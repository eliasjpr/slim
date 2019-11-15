require "../spec_helper"

module Operations::Subscriptions
  describe Invoices do
    subscription_id = 1
    start_date = Time.parse("09-01-2019", "%m-%d-%Y", Time::Location::UTC)

    describe "#call" do
      it "returns a list of invoices" do
      end
    end
  end
end
