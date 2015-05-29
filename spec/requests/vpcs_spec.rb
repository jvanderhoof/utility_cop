require 'rails_helper'

RSpec.describe "Vpcs", type: :request do
  describe "GET /vpcs" do
    it "works! (now write some real specs)" do
      get vpcs_path
      expect(response).to have_http_status(200)
    end
  end
end
