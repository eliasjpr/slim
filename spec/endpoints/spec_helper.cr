require "spec"
require "http"

VERSION_1 = HTTP::Headers{"Accept" => "application/vnd.slim.v1+json"}
CLIENT    = HTTP::Client.new ENV["HOST"], ENV["PORT"].to_i
