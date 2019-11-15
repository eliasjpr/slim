module Services
  module Subscriptions
    def self.find(id : Int64, &block)
      yield Clear::SQL.transaction do
        Subscription.find!(id)
      end
    end
  end
end
