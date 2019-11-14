module Services
  class Subscriptions
    def self.find(id : Int64, &block)
      yield Clear::SQL.transaction do
        subscription = Subscription.find!(id)
        subscription
      end
    end
  end
end
