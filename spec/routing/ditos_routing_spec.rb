require "spec_helper"

describe DitosController do
  describe "routing" do
    it "routes to #create" do
      expect(post("/ditos")).to route_to("ditos#create")
    end

    it "routes to #destroy" do
      expect(delete("/ditos/1")).to route_to("ditos#destroy", id: "1")
    end

  end
end
