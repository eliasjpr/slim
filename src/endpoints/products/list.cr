module Endpoints::Products
  struct List
    include Onyx::HTTP::Endpoint

    params do
      query do
        type limit : Int32 = 5
        type offset : Int32 = 0
      end
    end

    def call
      Services::Products.list params.query.offset, params.query.limit do |products|
        Serializers::Products.new products.not_nil!, params.query.offset, params.query.limit
      end
    end
  end
end
