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
        header "Cache-Control", "max-age=1800, s-max-age=3600, must-revalidate"
        Serializers::Subscriptions::Show.new subscription.not_nil!
      end
    end
  end
end
