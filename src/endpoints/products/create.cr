module Endpoints::Products
  struct Create
    include Onyx::HTTP::Endpoint

    params do
      json require: true do
        type data do
          type active : Bool
          type title : String
          type code : String
          type caption : String?
          type description : String?
          type attributes : String?
          type deactivate_on : Time?
          type shippable : Bool
          type kind : String
        end
      end
    end

    errors do
      type ProductError(404)
    end

    def call
      Operations::Products::Create.call(product) do |product|
        status 201
        header("Location", "/products/#{product.id}")
        Serializers::Product.new(product)
      end
    end

    private def product
      params.json
    end
  end
end
