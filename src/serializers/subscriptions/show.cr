module Serializers::Subscriptions
  struct Show
    include Onyx::HTTP::View

    def initialize(@data : Subscription)
    end

    json data: @data
  end
end
