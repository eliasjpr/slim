module Services
  class Products
    def self.find(id : Int64, &block)
      yield Clear::SQL.transaction do
        Product.find!(id)
      end
    end

    def self.create(product : Product)
      yield Clear::SQL.transaction do
        raise Errors::BadRequest.new(Product.name, product.print_errors) unless product.valid?
        product.save!
      end
    end

    def self.list(offset : Int32, limit : Int32)
      yield Clear::SQL.transaction do
        Product.query.limit(limit).offset(offset)
      end
    end
  end
end
