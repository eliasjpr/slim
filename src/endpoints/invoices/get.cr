module Endpoints::Invoices
  struct Get
    include Onyx::HTTP::Endpoint

    params do
      path do
        type id : Int64
        type start_date : Converters::Date
      end
    end

    def call
      Operations::Subscription::GenerateInvoices.call(params.path.id, start_date)
    end

    private def start_date : Time
      params.path.start_date.value
    end
  end
end
