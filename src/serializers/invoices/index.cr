module Serializers::Invoices
  struct Index
    include Onyx::HTTP::View
  
    def initialize(@data : Array(Bill))
    end
  
    json data: @data
  end
end
