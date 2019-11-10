module Endpoints
  struct Health
    include Onyx::HTTP::Endpoint

    def call
      Serializers::Health.new
    end
  end
end
