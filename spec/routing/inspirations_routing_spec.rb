require "spec_helper"

describe InspirationsController do
  describe "routing" do

    it "routes to #show" do
      expect(get("/challenges/1/inspirations/1")).to route_to("inspirations#show", challenge_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get("/challenges/1/inspirations/1/edit")).to route_to("inspirations#edit", challenge_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post("/challenges/1/inspirations")).to route_to("inspirations#create", challenge_id: "1")
    end

    it "routes to #update" do
      expect(put("/challenges/1/inspirations/1")).to route_to("inspirations#update", challenge_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete("/challenges/1/inspirations/1")).to route_to("inspirations#destroy", challenge_id: "1", id: "1")
    end

  end
end
