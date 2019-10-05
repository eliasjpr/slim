require "spec"
require "../../src/domain/billing_period.cr"

describe BillingPeriod do
  start_date = Time.parse("2017-01-02", "%Y-%m-%d", Time::Location::UTC)
  end_date = Time.parse("2017-12-31", "%Y-%m-%d", Time::Location::UTC)

  billing_period = BillingPeriod.new(start_date, end_date)

  it "calculates the total days between 2 dates" do
    billing_period.count.should eq 363
  end

  it "calculates all sundays between two days" do
    billing_period.count_by(Set{0}).should eq 52
  end

  it "calculates how many week days between two days" do
    billing_period.count_by(Set{1, 2, 3, 4, 5, 6}).should eq 311
  end

  it "calculates how many week days between monday to friday" do
    billing_period.count_by(Set{1, 2, 3, 4, 5}).should eq 259
  end
end
