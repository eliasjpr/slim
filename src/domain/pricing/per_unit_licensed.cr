# The seat-based model bills a price per quantity upfront on a recurring basis.
# This model best represents billing per user/seat for time based access.
#
# EXAMPLES
#
# CRM: ZOHO charges $20/user/month
# Customer Support: UserVoice charges $45/agent/month
#
# HOW TO SETUP THIS MODEL
#
# The seat-based model is a plan with a base recurring charge and the ability for the
# customer to select a quantity. If you are using our Hosted Payment Pages you will want
# to select the "Editable Quantity" checkbox, so your subscribers have the ability to set
# a quantity at sign-up.
#
# If you have a per seat/user charge separate from a base recurring charge, you can use
# fixed-price add-ons with editable quantities.
require "./price_model"

module Pricing
  class PerUnitLicensed < PriceModel
    getter usage : Int64 = 1
    getter billing_period : BillingPeriod
    getter plan : Plan
    getter product_plans : ProductPlan::Collection

    def initialize(@billing_period, @plan)
      @product_plans = plan.product_plans
    end

    def cost : Float64
      (product_charges + plan.amount) * usage
    end

    private def product_charges
      product_plans.to_a.reduce(0) do |acc, product_plan|
        acc + Cost.calc(billing_period, product_plan.amount, product_plan.days.to_set)
      end
    end
  end
end
