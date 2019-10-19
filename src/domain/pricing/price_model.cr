module Pricing
  abstract class PriceModel
    abstract def cost : Float64
  end
end
