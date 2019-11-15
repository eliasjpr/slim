require "onyx"
require "onyx/http"
require "clear"

require "./domain/**"
require "./converters/**"
require "./errors"
require "./services/**"
require "./serializers/**"
require "./endpoints/**"

module Slim
  include Onyx::HTTP

  Clear.logger.level = Onyx.logger.level
  Clear::SQL.init(ENV["DATABASE_URL"], connection_pool_size: ENV["DB_POOL_SIZE"].to_i32)

  Onyx::HTTP.get "/health", Endpoints::Health

  Onyx::HTTP.on "/products" do |router|
    router.post "/", Endpoints::Products::Create
    router.get "/", Endpoints::Products::List
    router.get "/:id", Endpoints::Products::Show
  end

  Onyx::HTTP.on "/invoices" do |router|
    router.get "/:subscription_id/:start_date", Endpoints::Invoices::Show
  end

  Onyx::HTTP.on "/subscriptions" do |router|
    router.get "/:id", Endpoints::Subscriptions::Show
  end
end
