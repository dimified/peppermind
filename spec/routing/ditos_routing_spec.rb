require "spec_helper"

describe DitosController do
  describe "routing" do
    it "routes to #create" do
      post("/ditos").should route_to("ditos#create")
    end

    it "routes to #destroy" do
      delete("/ditos/1").should route_to("ditos#destroy", id: "1")
    end

  end
end
