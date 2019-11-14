require "spec"
require "http"
require "json"
require "html"

VERSION_1 = HTTP::Headers{"Accept" => "application/json"}
CLIENT    = HTTP::Client.new ENV["HOST"], ENV["PORT"].to_i

def assert(stutus, key, response)
  response.status_code.should eq stutus
  response.body.should contain key
  response.headers["Content-Type"].should eq "application/json"
end
