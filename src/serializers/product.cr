module Serializers
  struct Product
    include ::Onyx::HTTP::View

    json data: @product

    def initialize(@product : ::Product)
    end

    def initialize(data : Endpoints::Products::Create::Params::JSON::Data)
      @product = ::Product.from_data(data)
    end
  end
end
