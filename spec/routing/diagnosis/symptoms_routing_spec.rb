require "spec_helper"

describe Diagnosis::SymptomsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diagnosis/symptoms").to route_to("diagnosis/symptoms#index")
    end

    it "routes to #new" do
      expect(:get => "/diagnosis/symptoms/new").to route_to("diagnosis/symptoms#new")
    end

    it "routes to #show" do
      expect(:get => "/diagnosis/symptoms/1").to route_to("diagnosis/symptoms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diagnosis/symptoms/1/edit").to route_to("diagnosis/symptoms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diagnosis/symptoms").to route_to("diagnosis/symptoms#create")
    end

    it "routes to #update" do
      expect(:put => "/diagnosis/symptoms/1").to route_to("diagnosis/symptoms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diagnosis/symptoms/1").to route_to("diagnosis/symptoms#destroy", :id => "1")
    end

  end
end
