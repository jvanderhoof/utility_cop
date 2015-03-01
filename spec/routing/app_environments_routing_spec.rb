require "rails_helper"

RSpec.describe AppEnvironmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/app_environments").to route_to("app_environments#index")
    end

    it "routes to #new" do
      expect(:get => "/app_environments/new").to route_to("app_environments#new")
    end

    it "routes to #show" do
      expect(:get => "/app_environments/1").to route_to("app_environments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/app_environments/1/edit").to route_to("app_environments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/app_environments").to route_to("app_environments#create")
    end

    it "routes to #update" do
      expect(:put => "/app_environments/1").to route_to("app_environments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/app_environments/1").to route_to("app_environments#destroy", :id => "1")
    end

  end
end
