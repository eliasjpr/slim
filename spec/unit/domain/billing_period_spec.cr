require "spec"
require "../../src/domain/billing_period.cr"

describe BillingPeriod do
  start_date = Time.parse("2017-01-02", "%Y-%m-%d", Time::Location::UTC)
  time_span = 12.months

  billing_period = BillingPeriod.new(start_date, time_span)

  it "calculates the total days between 2 dates" do
    billing_period.count.should eq 365
  end

  it "calculates all sundays between two days" do
    billing_period.count_by(Set{0}).should eq 52
  end

  it "calculates how many week days between two days" do
    billing_period.count_by(Set{1, 2, 3, 4, 5, 6}).should eq 312
  end

  it "calculates how many week days between monday to friday" do
    billing_period.count_by(Set{1, 2, 3, 4, 5}).should eq 260
  end
end
