require 'rails_helper'

RSpec.describe "AppCredentials", type: :request do
  describe "GET /app_credentials" do
    it "works! (now write some real specs)" do
      get app_credentials_path
      expect(response).to have_http_status(200)
    end
  end
end
