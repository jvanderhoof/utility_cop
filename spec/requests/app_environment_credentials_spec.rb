require 'rails_helper'

RSpec.describe "AppEnvironmentCredentials", type: :request do
  describe "GET /app_environment_credentials" do
    it "works! (now write some real specs)" do
      get app_environment_credentials_path
      expect(response).to have_http_status(200)
    end
  end
end
