require "spec_helper"

describe Treatment::PointPrescriptionsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/treatment/point_prescriptions").to route_to("treatment/point_prescriptions#index")
    end

    it "routes to #new" do
      expect(:get => "/treatment/point_prescriptions/new").to route_to("treatment/point_prescriptions#new")
    end

    it "routes to #show" do
      expect(:get => "/treatment/point_prescriptions/1").to route_to("treatment/point_prescriptions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/treatment/point_prescriptions/1/edit").to route_to("treatment/point_prescriptions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/treatment/point_prescriptions").to route_to("treatment/point_prescriptions#create")
    end

    it "routes to #update" do
      expect(:put => "/treatment/point_prescriptions/1").to route_to("treatment/point_prescriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/treatment/point_prescriptions/1").to route_to("treatment/point_prescriptions#destroy", :id => "1")
    end

  end
end
