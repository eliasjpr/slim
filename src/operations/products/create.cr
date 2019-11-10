module Operations::Products
  class Create
    @product : Product

    def self.call(product : Endpoints::Products::Create::Params::JSON, &block)
      product = Product.new({
        active:        product.data.active,
        title:         product.data.title,
        code:          product.data.code,
        caption:       product.data.caption,
        description:   product.data.description,
        deactivate_on: product.data.deactivate_on,
        shippable:     product.data.shippable,
        kind:          product.data.kind,
      })
      yield new(product).call
    end

    def initialize(@product : ::Product)
    end

    def call
      @product.save!
    end
  end
end
