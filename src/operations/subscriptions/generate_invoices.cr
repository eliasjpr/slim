module Operations::Subscriptions
  class GenerateInvoices
    def self.call(id : Int64, start_date : Time)
      new(id, start_date).call
    end

    def initialize(@id : Int64, @start_date : Time)
    end

    def call
      Serializers::Invoices::Index.new(invoices)
    end

    private def invoices
      Clear::SQL.transaction do
        raise Errors::SubscriptionNotFound.new(@id) unless Subscription.query.find({id: @id})
        SubscriptionPlan.invoice_for(@id, @start_date)
      end.not_nil!
    end
  end
end
