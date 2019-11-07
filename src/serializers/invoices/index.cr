module Serializers::Invoices
  struct Index
    include Onyx::HTTP::View

    def initialize(@data : Array(Bill))
      @payload = { data: @data }
    end

    json @payload
  end
end
