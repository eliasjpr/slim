module Serializers::Invoices
  struct Get
    include Onyx::HTTP::View

    def initialize(@invoices : Array(Bill))
    end

    json invoices: @invoices
  end
end
