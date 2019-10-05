Clear.enum AgregationTypes,
  :sum,                # for summing up all usage during a period
  :last_during_period, # for picking the last usage record reported within a period
  :last_ever,          # for picking the last usage record ever (across period bounds)
  :max                 # which picks the usage record with the maximum reported usage during a period

class UsesageType
  def initialize(@mode : Sumbol, aggregation : AgregationTypes)
  end
end
