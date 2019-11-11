Clear.enum ProductTypes, "home_delivery", "digital"

class Product
  include Clear::Model

  column id : Int64, primary: true, presence: false
  column active : Bool
  column title : String
  column code : String
  column caption : String?
  column description : String?
  column attributes : JSON::Any
  column deactivate_on : Time?
  column shippable : Bool
  column kind : ProductTypes

  def self.from_data(data)
    Product.new({
        active: data.active, 
        title: data.title, 
        code: data.code,
        caption: data.caption, 
        description: data.description,
        attributes: JSON.parse(data.attributes.not_nil!),
        deactivate_on: data.deactivate_on,
        shippable: data.shippable,
        kind: ProductTypes.from_string(data.kind)
      })
  end
end
