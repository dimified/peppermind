require "spec_helper"

describe LikesController do
  describe "routing" do
    it "routes to #create" do
      post("/likes").should route_to("likes#create")
    end

    it "routes to #destroy" do
      delete("/likes/1").should route_to("likes#destroy", id: "1")
    end

  end
end
