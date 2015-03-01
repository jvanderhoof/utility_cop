require 'rails_helper'

RSpec.describe "AppEnvironments", type: :request do
  describe "GET /app_environments" do
    it "works! (now write some real specs)" do
      get app_environments_path(app_id: create(:app).id)
      expect(response).to have_http_status(200)
    end
  end
end
