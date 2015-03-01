require "rails_helper"

RSpec.describe AppEnvironmentResourcesController, type: :routing do
  describe "routing" do

    it "routes to #edit" do
      expect(:get => "/app_environment_resources/1/edit").to route_to("app_environment_resources#edit", :id => "1")
    end

    it "routes to #update" do
      expect(:put => "/app_environment_resources/1").to route_to("app_environment_resources#update", :id => "1")
    end

  end
end
