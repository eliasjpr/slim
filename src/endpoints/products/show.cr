module Endpoints::Products
  struct Show
    include Onyx::HTTP::Endpoint

    params do
      path do
        type id : Int64
      end
    end

    def call
      Services::Products.find params.path.id do |product|
        raise Errors::NotFound.new(params.path.id, Product.name) unless product
        Serializers::Product.new product.not_nil!
      end
    end
  end
end
