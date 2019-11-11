require "../spec_helper"

describe "Endpoints::Products::Create" do
  describe "#call" do
    context "with valid payload" do
      it "returns 201 created" do
        payload = %q(
          {
            "data": {
              "title":         "News Paper",
              "active":        true,
              "code":          "NW",
              "caption":       "The new york times news paper",
              "description":   "",
              "attributes":    "{\"x\":1,\"y\":2}",
              "deactivate_on": "2019-11-11T20:07:59Z",
              "shippable":     true,
              "kind":          "home_delivery"
            }
          })
        
        response = CLIENT.post(path: "/products", headers: VERSION_1, body: payload)
        
        response.status_code.should eq 201
        response.body.should contain "data"
      end
    end
  end
end
