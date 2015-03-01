require 'rails_helper'

RSpec.describe "app_resources/show", type: :view do
  before(:each) do
    @app_resource = assign(:app_resource, create(:app_resource, app: create(:app), resource: create(:resource)))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(build(:app).name)
    expect(rendered).to match(build(:resource).name)
  end
end
