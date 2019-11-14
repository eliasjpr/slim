require "./spec_helper"

describe "Products Resource" do
  code = ('a'..'z').to_a.sample(2).join.to_s

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

  describe "GET /products" do
    it "returns a list of products" do
      id = create_product(payload)
      assert 200, "data", CLIENT.get(path: "/products", headers: VERSION_1)
    end
  end

  describe "GET /products/:id" do
    it "returns 200 ok with a single product" do
      id = create_product(payload)
      assert 200, "data", CLIENT.get(path: "/products/#{id}", headers: VERSION_1)
    end

    it "returns 404 Not found for invalid product id" do
      id = -1
      assert 404, "data", CLIENT.get(path: "/products/#{id}", headers: VERSION_1)
    end
  end

  describe "PATCH /products/:id" do
    it "returns 200 ok for patch product" do
      id = create_product(payload)
      assert 200, "data", CLIENT.get(path: "/products/#{id}", headers: VERSION_1)
    end
  end

  describe "POST /products" do
    it "returns 201 created with valid payload" do
      assert 201, "data", CLIENT.post(path: "/products", headers: VERSION_1, body: payload.to_json)
    end

    it "returns 400 bad request for duplicate title" do
      assert 400, "error", CLIENT.post(path: "/products", headers: VERSION_1, body: payload.to_json)
    end
  end
end

def create_product(payload)
  create = CLIENT.post(path: "/products", headers: VERSION_1, body: payload.to_json)
  product = JSON.parse create.body
  product["data"]["id"]
end
