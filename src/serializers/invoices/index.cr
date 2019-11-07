module Serializers::Invoices
  struct Index
    include Onyx::HTTP::View

    def initialize(@data : Array(Bill))
    end

    # Defined unless `to_json` is already defined
    def to_json(io : IO)
      {data: @data}.to_json(io)
    end

    # Defined unless `to_json` is already defined
    def to_json(builder : JSON::Builder)
      {data: @data}.to_json(builder)
    end

    def render(context)
      context.response.content_type = "application/vnd.api+json"
      to_json(context.response)
    end
  end
end
