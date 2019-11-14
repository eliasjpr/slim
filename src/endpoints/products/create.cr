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

    def call
      Services::Products.create product do |product|
        status 201
        header "Location", "/products/#{product.not_nil!.id}"
        Serializers::Product.new product.not_nil!
      end
    end

    private def product
      Product.build_from params.json
    end
  end
end
