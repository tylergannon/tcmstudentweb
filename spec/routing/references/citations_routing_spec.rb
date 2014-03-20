require "spec_helper"

describe References::CitationsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/references/citations").to route_to("references/citations#index")
    end

    it "routes to #new" do
      expect(:get => "/references/citations/new").to route_to("references/citations#new")
    end

    it "routes to #show" do
      expect(:get => "/references/citations/1").to route_to("references/citations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/references/citations/1/edit").to route_to("references/citations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/references/citations").to route_to("references/citations#create")
    end

    it "routes to #update" do
      expect(:put => "/references/citations/1").to route_to("references/citations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/references/citations/1").to route_to("references/citations#destroy", :id => "1")
    end

  end
end
