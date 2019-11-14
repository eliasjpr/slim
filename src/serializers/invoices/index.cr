module Serializers::Invoices
  struct Index
    include Onyx::HTTP::View

    json data: @data

    def initialize(@data : Array(Bill))
    end
  end
end
