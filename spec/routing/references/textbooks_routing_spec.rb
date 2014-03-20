require "spec_helper"

describe References::TextbooksController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/references/textbooks").to route_to("references/textbooks#index")
    end

    it "routes to #new" do
      expect(:get => "/references/textbooks/new").to route_to("references/textbooks#new")
    end

    it "routes to #show" do
      expect(:get => "/references/textbooks/1").to route_to("references/textbooks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/references/textbooks/1/edit").to route_to("references/textbooks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/references/textbooks").to route_to("references/textbooks#create")
    end

    it "routes to #update" do
      expect(:put => "/references/textbooks/1").to route_to("references/textbooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/references/textbooks/1").to route_to("references/textbooks#destroy", :id => "1")
    end

  end
end
