require "spec_helper"

describe References::AuthorsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/references/authors").to route_to("references/authors#index")
    end

    it "routes to #new" do
      expect(:get => "/references/authors/new").to route_to("references/authors#new")
    end

    it "routes to #show" do
      expect(:get => "/references/authors/1").to route_to("references/authors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/references/authors/1/edit").to route_to("references/authors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/references/authors").to route_to("references/authors#create")
    end

    it "routes to #update" do
      expect(:put => "/references/authors/1").to route_to("references/authors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/references/authors/1").to route_to("references/authors#destroy", :id => "1")
    end

  end
end
