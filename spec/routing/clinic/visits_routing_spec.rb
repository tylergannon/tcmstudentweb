require "spec_helper"

describe Clinic::VisitsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/clinic/visits").to route_to("clinic/visits#index")
    end

    it "routes to #new" do
      expect(:get => "/clinic/visits/new").to route_to("clinic/visits#new")
    end

    it "routes to #show" do
      expect(:get => "/clinic/visits/1").to route_to("clinic/visits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/clinic/visits/1/edit").to route_to("clinic/visits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/clinic/visits").to route_to("clinic/visits#create")
    end

    it "routes to #update" do
      expect(:put => "/clinic/visits/1").to route_to("clinic/visits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/clinic/visits/1").to route_to("clinic/visits#destroy", :id => "1")
    end

  end
end
