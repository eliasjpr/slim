module Pricing
  def self.cost(billing_period : BillingPeriod, plan : Plan)
    pricing = case plan.usage_type
              when UsageTypes::Licensed  then Pricing::PerUnitLicensed
              when UsageTypes::Volume    then Pricing::TieredVolume
              else
                raise "Pricing scheme #{plan.usage_type} not supported!"
              end

    pricing.new(billing_period, plan).cost
  end
end
