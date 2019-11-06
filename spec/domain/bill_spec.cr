require "./spec_helper"
require "../../src/domain/bill.cr"

def setup_scenario(products : Array(Tuple(Float64, Array(Int32))), num_of_copies : Int32, unit : BillingCycles, interval : Int32)
  plan = create_plan(UUID.random.to_s, unit, interval, UsageTypes::Licensed, BillingScheme::PerUnit)

  products.each do |(rate, days)|
    dow = days.map { |d| Time::DayOfWeek.from_value(d) }
    product = create_product("#{dow.join(", ")[0...25]}(#{rate})", ('A'..'Z').to_a.shuffle[0..1].join(""))
    create_product_plan(product, plan, rate, days)
  end

  subscription = create_subscription(1, plan.trial_period_days, plan.bill_cycle)
  create_subscription_plan(subscription, plan, num_of_copies)
end

describe Bill do
  describe "performs aristo billing" do
    it "" do
      clear
      products = [{8.5, [0]}]
      start_date = Time.parse("09-09-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 34.00
      clear
    end

    it "" do
      clear
      products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 76.00
      clear
    end

    it "" do
      clear
      products = [{2.5, [1, 2, 3, 4, 5, 6]}]
      start_date = Time.parse("04-15-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 26)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 390.00
      clear
    end

    it "" do
      clear
      products = [{0.718, [1, 2, 3, 4, 5, 6]}, {4.308, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 34.46
      clear
    end

    it "" do
      clear
      products = [{1.673, [1, 2, 3, 4, 5, 6]}, {8.213, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 13)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 237.26
    end

    it "" do
      clear
      products = [{1.627, [1, 2, 3, 4, 5, 6]}, {7.988, [0]}]
      start_date = Time.parse("06-17-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 26)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 461.5
    end

    it "" do
      clear
      products = [{1.673, [1, 2, 3, 4, 5, 6]}, {8.213, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 26)
      create_credit_note(1, 1.671, created_at: start_date + 3.days)

      invoice = Bill.new(subscription_plan, start_date)

      invoice.subtotal.should eq 472.86
    end

    it "" do
      clear
      products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
      start_date = Time.parse("08-05-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)

      invoice = Bill.new(subscription_plan, start_date)

      invoice.charges.should eq 76
      clear
    end

    it "" do
      clear
      products = [{1.673, [1, 2, 3, 4, 5, 6]}, {8.213, [0]}]
      start_date = Time.parse("07-01-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 26)
      create_credit_note(1, 252.17, created_at: start_date + 3.days)

      invoice = Bill.new(subscription_plan, start_date)

      invoice.subtotal.should eq 222.36
      clear
    end

    it "" do
      clear
      products = [{0.841, [1, 2, 3, 4, 5, 6]}, {4.205, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 26)

      invoice = Bill.new(subscription_plan, start_date)

      invoice.charges.should eq 240.53
      clear
    end

    it "" do
      clear
      products = [{1.5, [1, 2, 3, 4, 5, 6]}, {7.25, [0]}]
      start_date = Time.parse("09-23-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 26)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 422.5
    end

    it "" do
      clear
      products = [{2.50, [3, 6]}, {8.739, [0]}]
      start_date = Time.parse("09-23-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)
      create_credit_note(1, 1517.64, created_at: start_date + 3.days)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 54.96
      invoice.credits.should eq 1517.64
      invoice.subtotal.should eq -1462.68
    end

    it "" do
      clear
      products = [{0.841, [1, 2, 3, 4, 5, 6]}, {4.205, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)
      create_credit_note(1, 9.26, created_at: start_date + 3.days)
      create_credit_note(1, 6.73, created_at: start_date + 3.days)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 37.0
      invoice.credits.should eq 15.99
      invoice.subtotal.should eq 21.01
    end

    it "" do
      clear
      products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
      start_date = Time.parse("07-29-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)
      create_credit_note(1, 5.22, created_at: start_date + 3.days)

      invoice = Bill.new(subscription_plan, start_date)
      invoice.charges.should eq 76.0
      invoice.credits.should eq 5.22
      invoice.subtotal.should eq 70.78
    end

    it "" do
      clear
      products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
      start_date = Time.parse("09-26-2019", "%m-%d-%Y", Time::Location::UTC)
      subscription_plan = setup_scenario(products, 1, BillingCycles::Week, 4)
      create_credit_note(1, 5.22, created_at: start_date + 3.days)
      coupon = create_coupon(amount: 12.45)
      create_discount(coupon, subscription_plan.subscription, starts_on: start_date + 3.days)

      invoice = Bill.new(subscription_plan, start_date)

      invoice.discounts.should eq 12.45
      invoice.charges.should eq 76.0
      invoice.credits.should eq 5.22
      invoice.subtotal.should eq 70.78
    end
  end
end
