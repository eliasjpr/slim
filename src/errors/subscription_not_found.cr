module Errors
  class SubscriptionNotFound < Onyx::HTTP::Error(404)
    def initialize(@id : Int64)
      super("Subscription not found with this id")
    end

    def payload
      {id: @id}
    end
  end
end