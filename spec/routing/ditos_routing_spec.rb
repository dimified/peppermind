require "spec_helper"

describe DitosController do
  describe "routing" do

    it "routes to #index" do
      get("/ditos").should route_to("ditos#index")
    end

    it "routes to #new" do
      get("/ditos/new").should route_to("ditos#new")
    end

    it "routes to #show" do
      get("/ditos/1").should route_to("ditos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ditos/1/edit").should route_to("ditos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ditos").should route_to("ditos#create")
    end

    it "routes to #update" do
      put("/ditos/1").should route_to("ditos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ditos/1").should route_to("ditos#destroy", :id => "1")
    end

  end
end
