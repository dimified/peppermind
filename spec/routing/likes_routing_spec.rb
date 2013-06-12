require "spec_helper"

describe LikesController do
  describe "routing" do
    it "routes to #create" do
      expect(post("/likes")).to route_to("likes#create")
    end

    it "routes to #destroy" do
      expect(delete("/likes/1")).to route_to("likes#destroy", id: "1")
    end

  end
end
