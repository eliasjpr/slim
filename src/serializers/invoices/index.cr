module Serializers::Invoices
  struct Index
    include Onyx::HTTP::View

    def initialize(@invoices : Array(Bill))
    end

    json invoices: @invoices
  end
end
