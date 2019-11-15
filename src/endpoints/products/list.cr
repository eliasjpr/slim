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
        header "Cache-Control", "max-age=1800, s-max-age=3600, must-revalidate"
        Serializers::Products.new products.not_nil!, params.query.limit, params.query.offset
      end
    end
  end
end
