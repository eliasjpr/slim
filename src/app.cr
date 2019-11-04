require "onyx"
require "onyx/http"
require "clear"

require "./converters/**"
require "./domain/**"
require "./operations/**"
require "./serializers/**"
require "./endpoints/**"

module Slim
  include Onyx::HTTP 
  Clear.logger.level = ENV["CRYSTAL_ENV"]? != "production" ? ::Logger::INFO : ::Logger::DEBUG 
  Clear::SQL.init(ENV["DATABASE_URL"], connection_pool_size: ENV["DB_POOL_SIZE"].to_i32)
  Onyx::HTTP.get "/invoices/:id/:start_date", Endpoints::Invoices::Index
end
