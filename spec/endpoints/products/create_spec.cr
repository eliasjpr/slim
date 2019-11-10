require "../spec_helper"
require "html"

describe "Endpoints::Products::Create" do
  describe "#call" do
    context "with valid payload" do
      it "returns 201 created" do
        code = ('a'..'z').to_a.sample(2).join.to_s
        payload = %Q(
          {
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
          })

        response = CLIENT.post(path: "/products", headers: VERSION_1, body: payload)

        response.status_code.should eq 201
        response.body.should contain "data"
        response.headers["Location"].should eq "/products/#{json["data"]["id"]}"
      end
    end
  end
end
