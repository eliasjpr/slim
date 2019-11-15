module Serializers
  struct Subscription
    include Onyx::HTTP::View

    def initialize(@data : ::Subscription)
    end

    json data: @data
  end
end
