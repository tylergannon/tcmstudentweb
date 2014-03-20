require "spec_helper"

describe Treatment::PointPrescriptionPointsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/treatment/point_prescription_points").to route_to("treatment/point_prescription_points#index")
    end

    it "routes to #new" do
      expect(:get => "/treatment/point_prescription_points/new").to route_to("treatment/point_prescription_points#new")
    end

    it "routes to #show" do
      expect(:get => "/treatment/point_prescription_points/1").to route_to("treatment/point_prescription_points#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/treatment/point_prescription_points/1/edit").to route_to("treatment/point_prescription_points#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/treatment/point_prescription_points").to route_to("treatment/point_prescription_points#create")
    end

    it "routes to #update" do
      expect(:put => "/treatment/point_prescription_points/1").to route_to("treatment/point_prescription_points#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/treatment/point_prescription_points/1").to route_to("treatment/point_prescription_points#destroy", :id => "1")
    end

  end
end
