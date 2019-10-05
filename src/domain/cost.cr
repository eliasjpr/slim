class Cost
  def self.calc(billing_period, rate : Float64, days : Set(Int32))
    new(billing_period, rate, days).total
  end

  def initialize(@billing_period : BillingPeriod, @rate : Float64, @days : Set(Int32))
  end

  def total
    @billing_period.count_by(@days) * @rate
  end
end
