require "spec_helper"

describe Acupuncture::ChannelsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/acupuncture/channels").to route_to("acupuncture/channels#index")
    end

    it "routes to #new" do
      expect(:get => "/acupuncture/channels/new").to route_to("acupuncture/channels#new")
    end

    it "routes to #show" do
      expect(:get => "/acupuncture/channels/1").to route_to("acupuncture/channels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acupuncture/channels/1/edit").to route_to("acupuncture/channels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/acupuncture/channels").to route_to("acupuncture/channels#create")
    end

    it "routes to #update" do
      expect(:put => "/acupuncture/channels/1").to route_to("acupuncture/channels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acupuncture/channels/1").to route_to("acupuncture/channels#destroy", :id => "1")
    end

  end
end
