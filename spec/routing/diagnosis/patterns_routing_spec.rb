require "spec_helper"

describe Diagnosis::PatternsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diagnosis/patterns").to route_to("diagnosis/patterns#index")
    end

    it "routes to #new" do
      expect(:get => "/diagnosis/patterns/new").to route_to("diagnosis/patterns#new")
    end

    it "routes to #show" do
      expect(:get => "/diagnosis/patterns/1").to route_to("diagnosis/patterns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diagnosis/patterns/1/edit").to route_to("diagnosis/patterns#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diagnosis/patterns").to route_to("diagnosis/patterns#create")
    end

    it "routes to #update" do
      expect(:put => "/diagnosis/patterns/1").to route_to("diagnosis/patterns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diagnosis/patterns/1").to route_to("diagnosis/patterns#destroy", :id => "1")
    end

  end
end
