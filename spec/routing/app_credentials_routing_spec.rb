require "rails_helper"

RSpec.describe AppCredentialsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/app_credentials").to route_to("app_credentials#index")
    end

    it "routes to #new" do
      expect(:get => "/app_credentials/new").to route_to("app_credentials#new")
    end

    it "routes to #show" do
      expect(:get => "/app_credentials/1").to route_to("app_credentials#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/app_credentials/1/edit").to route_to("app_credentials#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/app_credentials").to route_to("app_credentials#create")
    end

    it "routes to #update" do
      expect(:put => "/app_credentials/1").to route_to("app_credentials#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/app_credentials/1").to route_to("app_credentials#destroy", :id => "1")
    end

  end
end
