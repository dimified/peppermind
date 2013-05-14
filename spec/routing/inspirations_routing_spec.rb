require "spec_helper"

describe InspirationsController do
  describe "routing" do

    it "routes to #index" do
      get("/inspirations").should route_to("inspirations#index")
    end

    it "routes to #new" do
      get("/inspirations/new").should route_to("inspirations#new")
    end

    it "routes to #show" do
      get("/inspirations/1").should route_to("inspirations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inspirations/1/edit").should route_to("inspirations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inspirations").should route_to("inspirations#create")
    end

    it "routes to #update" do
      put("/inspirations/1").should route_to("inspirations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inspirations/1").should route_to("inspirations#destroy", :id => "1")
    end

  end
end
