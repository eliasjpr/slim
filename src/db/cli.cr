require "../app"
require "./migrations/*"
require "onyx/env"
require "../../spec/helpers"

def initdb
  Clear.logger.level = ::Logger::INFO
end

initdb

Clear.with_cli do
  puts "Usage: crystal src/cli/cli.cr -- clear [args]"
end

Clear.seed do
  # Clear DB
  clear

  start_date = Time.parse("09-09-2019", "%m-%d-%Y", Time::Location::UTC)

  # # Subs 1
  products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
  setup_scenario(3, products, 1, BillingCycles::Week, 4)

  # # Subs 2
  products = [{1.673, [1, 2, 3, 4, 5, 6]}, {8.213, [0]}]
  setup_scenario(1, products, 1, BillingCycles::Week, 26)
  create_credit_note(1, 1.671, created_at: start_date + 3.days)

  # # Subs 3
  products = [{1.673, [1, 2, 3, 4, 5, 6]}, {8.213, [0]}]
  setup_scenario(2, products, 1, BillingCycles::Week, 26)
  create_credit_note(2, 252.17, created_at: start_date + 3.days)

  products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
  start_date = Time.parse("09-26-2019", "%m-%d-%Y", Time::Location::UTC)
  subscription_plan = setup_scenario(4, products, 1, BillingCycles::Week, 4)
  create_credit_note(1, 5.22, created_at: start_date + 3.days)
  coupon = create_coupon(amount: 12.45)
  create_discount(coupon, subscription_plan.subscription, starts_on: start_date + 3.days)

  products = [{1.74, [1, 2, 3, 4, 5, 6]}, {8.56, [0]}]
  start_date = Time.parse("09-26-2019", "%m-%d-%Y", Time::Location::UTC)
  subscription_plan = setup_scenario(5, products, 1, BillingCycles::Week, 4)
  create_credit_note(1, 5.22, created_at: start_date + 3.days)
  coupon = create_coupon(percent: 0.45, amount: nil)
  create_discount(coupon, subscription_plan.subscription, id: 5, starts_on: start_date + 3.days)
end

def setup_scenario(id, products : Array(Tuple(Float64, Array(Int32))), num_of_copies : Int32, unit : BillingCycles, interval : Int32)
  plan = create_plan("Seed-#{UUID.random}", unit, interval, UsageTypes::Licensed, BillingScheme::PerUnit)

  products.each do |(rate, days)|
    days.map { |d| Time::DayOfWeek.from_value(d) }
    product = create_product("Prd-#{UUID.random}", ('A'..'Z').to_a.shuffle[0..1].join(""))
    create_product_plan(product, plan, rate, days)
  end

  subscription = create_subscription(1, plan.trial_period_days, plan.bill_cycle)
  create_subscription_plan(subscription, plan, num_of_copies)
end
