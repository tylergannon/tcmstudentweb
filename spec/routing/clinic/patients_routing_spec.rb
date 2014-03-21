require "spec_helper"

describe Clinic::PatientsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/clinic/patients").to route_to("clinic/patients#index")
    end

    it "routes to #new" do
      expect(:get => "/clinic/patients/new").to route_to("clinic/patients#new")
    end

    it "routes to #show" do
      expect(:get => "/clinic/patients/1").to route_to("clinic/patients#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/clinic/patients/1/edit").to route_to("clinic/patients#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/clinic/patients").to route_to("clinic/patients#create")
    end

    it "routes to #update" do
      expect(:put => "/clinic/patients/1").to route_to("clinic/patients#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/clinic/patients/1").to route_to("clinic/patients#destroy", :id => "1")
    end

  end
end
