
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
      status 201
      product = Product.from_data(params.json.data)
      product.save!
      Serializers::Products::Create.new product
    end
  end
end
