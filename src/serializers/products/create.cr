module Serializers::Products
  struct Create
    include Onyx::HTTP::View

    def initialize(@data : Product)
    end

    json data: @data
  end
end
