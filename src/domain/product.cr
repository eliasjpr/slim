Clear.enum ProductTypes, "home_delivery", "digital"

class Product
  include Clear::Model

  def self.build_from(product : Endpoints::Products::Create::Params::JSON)
    Product.new({
      active:        product.data.active,
      title:         product.data.title,
      code:          product.data.code,
      caption:       product.data.caption,
      description:   product.data.description,
      deactivate_on: product.data.deactivate_on,
      shippable:     product.data.shippable,
      kind:          product.data.kind,
    })
  end

  column id : Int64, primary: true, presence: false
  column active : Bool
  column title : String
  column code : String
  column caption : String?
  column description : String?
  column attributes : JSON::Any?
  column deactivate_on : Time?
  column shippable : Bool
  column kind : ProductTypes
end
