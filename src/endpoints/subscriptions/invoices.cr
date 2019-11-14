module Endpoints::Subscriptions
  struct Invoices
    include Onyx::HTTP::Endpoint

    params do
      path do
        type id : Int64
        type start_date : Converters::Date
      end
    end

    def call
      Services::Invoices.call params.path.id, start_date do |invoices|
        Serializers::Invoices::Index.new(invoices)
      end
    end

    private def start_date : Time
      params.path.start_date.value
    end
  end
end
