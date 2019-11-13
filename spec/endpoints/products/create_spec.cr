require "../spec_helper"

describe "Endpoints::Products::Create" do
  code = ('a'..'z').to_a.sample(2).join.to_s

  describe "#call" do
    payload = JSON.parse(%Q({
        "data": {
          "active":        true,
          "title":         "News #{code}",
          "code":          "#{code}",
          "caption":       "The new york times news paper",
          "description":   "",
          "deactivate_on": "2019-11-11T20:07:59Z",
          "shippable":     true,
          "kind":          "home_delivery"
        }
      }))

    it "returns 201 created with valid payload" do
      assert 201, "data", CLIENT.post(path: "/products", headers: VERSION_1, body: payload.to_json)
    end

    it "returns 400 bad request for duplicate title" do
      assert 400, "error", CLIENT.post(path: "/products", headers: VERSION_1, body: payload.to_json)
    end
  end
end

def assert(stutus, key, response)
  response.status_code.should eq stutus
  response.body.should contain key
  response.headers["Content-Type"].should eq "application/json"
end
