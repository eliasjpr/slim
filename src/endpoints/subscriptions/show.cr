module Endpoints::Subscriptions
  struct Show
    include Onyx::HTTP::Endpoint

    params do
      path do
        type id : Int64
      end
    end

    def call
      Services::Subscriptions.find params.path.id do |subscription|
        raise Errors::NotFound.new(params.path.id, Subscription.name) unless subscription
        Serializers::Subscriptions::Show.new subscription.not_nil!
      end
    end
  end
end
