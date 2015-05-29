require "rails_helper"

RSpec.describe VpcsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/vpcs").to route_to("vpcs#index")
    end

    it "routes to #new" do
      expect(:get => "/vpcs/new").to route_to("vpcs#new")
    end

    it "routes to #show" do
      expect(:get => "/vpcs/1").to route_to("vpcs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/vpcs/1/edit").to route_to("vpcs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/vpcs").to route_to("vpcs#create")
    end

    it "routes to #update" do
      expect(:put => "/vpcs/1").to route_to("vpcs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vpcs/1").to route_to("vpcs#destroy", :id => "1")
    end

  end
end
