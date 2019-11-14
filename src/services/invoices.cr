module Services
  class Invoices
    def self.call(id : Int64, start_date : Time, &block)
      yield new(id, start_date).call
    end

    def initialize(@id : Int64, @start_date : Time)
    end

    def call
      Clear::SQL.transaction do
        raise Errors::NotFound.new(@id, Subscription.name) unless Subscription.query.find({id: @id})
        SubscriptionPlan.invoice_for(@id, @start_date)
      end.not_nil!
    end
  end
end
