module Serializers
  struct Invoices
    include Onyx::HTTP::View

    json data: @data

    def initialize(@data : Array(Bill))
    end
  end
end
