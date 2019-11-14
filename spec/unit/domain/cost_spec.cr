require "./spec_helper"
require "../../../src/domain/cost.cr"

describe Cost do
  start_date = Time.parse("2017-01-02", "%Y-%m-%d", Time::Location::UTC)
  time_span = 12.months
  billing_period = BillingPeriod.new(start_date, time_span)
  sunday_rate = 1.67
  daily_rate = 2.00

  it "calculates the cost for sundays within date range" do
    subject = Cost.new(billing_period, sunday_rate, Set{0})

    subject.total.round(2).should eq 86.84
  end

  it "calculates the cost for daily within date range" do
    subject = Cost.new(billing_period, daily_rate, Set{1, 2, 3, 4, 5, 6})

    subject.total.should eq 624.0
  end
end
