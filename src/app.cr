require "onyx"
require "onyx/http"
require "clear"

require "./converters/**"
require "./errors/**"
require "./domain/**"
require "./operations/**"
require "./serializers/**"
require "./endpoints/**"

module Slim
  include Onyx::HTTP

  Clear.logger.level = Onyx.logger.level
  Clear::SQL.init(ENV["DATABASE_URL"], connection_pool_size: ENV["DB_POOL_SIZE"].to_i32)
  
  # Routes
  Onyx::HTTP.get "/subscriptions/:id/invoices/:start_date", Endpoints::Subscriptions::Invoices
  Onyx::HTTP.get "/subscriptions/:id", Endpoints::Subscriptions::Show
end
