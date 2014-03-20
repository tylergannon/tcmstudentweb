require "spec_helper"

describe Acupuncture::PointsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/acupuncture/points").to route_to("acupuncture/points#index")
    end

    it "routes to #new" do
      expect(:get => "/acupuncture/points/new").to route_to("acupuncture/points#new")
    end

    it "routes to #show" do
      expect(:get => "/acupuncture/points/1").to route_to("acupuncture/points#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acupuncture/points/1/edit").to route_to("acupuncture/points#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/acupuncture/points").to route_to("acupuncture/points#create")
    end

    it "routes to #update" do
      expect(:put => "/acupuncture/points/1").to route_to("acupuncture/points#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acupuncture/points/1").to route_to("acupuncture/points#destroy", :id => "1")
    end

  end
end
