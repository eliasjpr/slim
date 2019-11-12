require "onyx"
require "onyx/http"
require "clear"

require "./domain/**"
require "./converters/**"
require "./errors/**"
require "./operations/**"
require "./serializers/**"
require "./endpoints/**"

module Slim
  include Onyx::HTTP

  Clear.logger.level = Onyx.logger.level
  Clear::SQL.init(ENV["DATABASE_URL"], connection_pool_size: ENV["DB_POOL_SIZE"].to_i32)

  # Routes
  Onyx::HTTP.get "/health", Endpoints::Health

  Onyx::HTTP.post "/products", Endpoints::Products::Create

  Onyx::HTTP.get "/subscriptions/:id/invoices/:start_date", Endpoints::Subscriptions::Invoices
  Onyx::HTTP.get "/subscriptions/:id", Endpoints::Subscriptions::Show
end
