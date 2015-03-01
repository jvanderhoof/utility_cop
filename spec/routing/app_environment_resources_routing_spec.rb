require "rails_helper"

RSpec.describe AppEnvironmentResourcesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/app_environment_resources").to route_to("app_environment_resources#index")
    end

    it "routes to #new" do
      expect(:get => "/app_environment_resources/new").to route_to("app_environment_resources#new")
    end

    it "routes to #show" do
      expect(:get => "/app_environment_resources/1").to route_to("app_environment_resources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/app_environment_resources/1/edit").to route_to("app_environment_resources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/app_environment_resources").to route_to("app_environment_resources#create")
    end

    it "routes to #update" do
      expect(:put => "/app_environment_resources/1").to route_to("app_environment_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/app_environment_resources/1").to route_to("app_environment_resources#destroy", :id => "1")
    end

  end
end
