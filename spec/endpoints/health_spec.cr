require "../spec_helper"

describe "Endpoints::Health" do
  describe "#call" do
    context "with valid payload" do
      it "returns 200 success" do
        response = CLIENT.get "/health", headers: VERSION_1
        response.status_code.should eq 200
        response.body.should contain "data"
      end
    end
  end
end