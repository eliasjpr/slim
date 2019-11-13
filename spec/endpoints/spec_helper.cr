require "spec"
require "http"
require "json"
require "html"

VERSION_1 = HTTP::Headers{"Accept" => "application/json"}
CLIENT    = HTTP::Client.new ENV["HOST"], ENV["PORT"].to_i
