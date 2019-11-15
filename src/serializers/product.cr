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

  struct Products
    include ::Onyx::HTTP::View

    json({
      page: {
        limit:  @limit,
        offset: @offset,
      },
      data: @products.to_a,
    })

    def initialize(@products : ::Product::Collection, @limit : Int32, @offset : Int32)
    end
  end
end
