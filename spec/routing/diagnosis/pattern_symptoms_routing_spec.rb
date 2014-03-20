require "spec_helper"

describe Diagnosis::PatternSymptomsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diagnosis/pattern_symptoms").to route_to("diagnosis/pattern_symptoms#index")
    end

    it "routes to #new" do
      expect(:get => "/diagnosis/pattern_symptoms/new").to route_to("diagnosis/pattern_symptoms#new")
    end

    it "routes to #show" do
      expect(:get => "/diagnosis/pattern_symptoms/1").to route_to("diagnosis/pattern_symptoms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diagnosis/pattern_symptoms/1/edit").to route_to("diagnosis/pattern_symptoms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diagnosis/pattern_symptoms").to route_to("diagnosis/pattern_symptoms#create")
    end

    it "routes to #update" do
      expect(:put => "/diagnosis/pattern_symptoms/1").to route_to("diagnosis/pattern_symptoms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diagnosis/pattern_symptoms/1").to route_to("diagnosis/pattern_symptoms#destroy", :id => "1")
    end

  end
end
