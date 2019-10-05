class ProductPlan
  include Clear::Model

  belongs_to plan : Plan
  belongs_to product : Product

  column id : Int64, primary: true, presence: false
  column amount : Float64
  column days : Array(Int32)
end
