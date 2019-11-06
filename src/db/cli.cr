require "../app"
require "./migrations/*"

def initdb
  Clear.logger.level = ::Logger::INFO
end

initdb

Clear.with_cli do
  puts "Usage: crystal src/cli/cli.cr -- clear [args]"
end
