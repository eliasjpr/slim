module Pricing
  class TieredVolume < PriceModel
    getter usage : Int64 = 0
    getter billing_period : BillingPeriod
    getter plan : Plan

    def initialize(@billing_period, @plan)
    end

    def cost
      (product_charges + plan.amount) * usage
    end

    private def product_charges
      product_plans.to_a.reduce(0) do |acc, product_plan|
        acc + Cost.calc(billing_period, tier_amount, product_plan_days)
      end
    end

    private def quantity
      plan.subscription.quantity
    end

    private def product_plans_days
      plan.product_plans.days.to_set
    end

    private def tier_amount
      Tier.volume(plan.id, usage).amount
    end
  end
end
