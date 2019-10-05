require "../../config/application"
require "./migrations/*"

def initdb
  Clear.logger.level = ::Logger::INFO
end

initdb

Clear.with_cli do
  puts "Usage: crystal sample/cli/cli.cr -- clear [args]"
end
