module Endpoints::Subscriptions
  struct Show
    include Onyx::HTTP::Endpoint

    params do
      path do
        type id : Int64
      end
    end

    def call
      subscription = Subscription.find(params.path.id)
      raise Errors::SubscriptionNotFound.new(params.path.id) unless subscription
      Serializers::Subscriptions::Show.new(subscription)
    end
  end
end