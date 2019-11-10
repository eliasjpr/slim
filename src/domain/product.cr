Clear.enum ProductTypes, "home_delivery", "digital"

class Product
  include Clear::Model

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
