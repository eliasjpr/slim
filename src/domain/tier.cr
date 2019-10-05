class Tier
  include Clear::Model

  belongs_to plan : Plan

  column id : Int64, primary: true, presence: false
  column quantity : Int32 = 0
  column amount : Float64 = 0.0

  def self.volume(id, quantity)
    query.where {
      (plan_id == id) &
        (quantity <= quantity)
    }.order_by("quantity", "desc").first!
  end
end
