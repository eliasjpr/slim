module Services
  module Invoices
    def self.for(id : Int64, start_date : Time, &block)
      yield Clear::SQL.transaction do
        SubscriptionPlan.invoice_for(id, start_date)
      end
    end
  end
end
