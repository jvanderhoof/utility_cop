require 'rails_helper'

RSpec.describe "app_resources/index", type: :view do
  before(:each) do
    assign(:app, create(:app, app_resources: [
      build(:app_resource, resource: build(:resource)),
      build(:app_resource, resource: build(:resource))
    ]))
  end

  it "renders a list of app_resources" do
    render
    assert_select "tr>td", :text => build(:app).name, :count => 2
    assert_select "tr>td", :text => build(:resource).name, :count => 2
  end
end
