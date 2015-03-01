require 'rails_helper'

RSpec.describe "AppEnvironmentResources", type: :request do
  describe "GET /app_environment_resources" do
    it "works! (now write some real specs)" do
      get app_environment_resources_path
      expect(response).to have_http_status(200)
    end
  end
end
