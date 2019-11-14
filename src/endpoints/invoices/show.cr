module Endpoints::Invoices
  struct Show
    include Onyx::HTTP::Endpoint

    params do
      path do
        type subscription_id : Int64
        type start_date : Converters::Date
      end
    end

    def call
      Services::Invoices.for subscription_id, start_date do |invoices|
        raise Errors::NotFound.new(subscription_id, Subscription.name) unless invoices
        header "Cache-Control", "max-age=1800, s-max-age=3600, must-revalidate"
        Serializers::Invoices::Index.new invoices.not_nil!
      end
    end

    private def start_date : Time
      params.path.start_date.value
    end

    private def subscription_id
      params.path.subscription_id
    end
  end
end
