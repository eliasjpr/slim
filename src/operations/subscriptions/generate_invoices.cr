module Operations::Subscriptions
  class GenerateInvoices
    def self.call(id : Int64, start_date : Time)
      new(id, start_date).call
    end
  
    def initialize(@id : Int64, @start_date : Time)
    end
  
    def call
      Serializers::Invoices::Get.new(invoices)
    end
  
    private def invoices
      Subscription.query.find!({id: @id}).invoices(@start_date)
    end
  end
end