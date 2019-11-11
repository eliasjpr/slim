require "spec"
require "http"
require "../helpers"
require "../../src/app"

VERSION_1 = HTTP::Headers{"Accept" => "application/vnd.slim.v1+json"}
CLIENT    = HTTP::Client.new ENV["HOST"], ENV["PORT"].to_i

Process.new("./bin/slim").wait