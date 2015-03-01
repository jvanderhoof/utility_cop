require 'rails_helper'

RSpec.describe "app_environments/index", type: :view do
  before(:each) do
    assign(:app, create(:app, app_environments: [
      build(:app_environment, environment: build(:environment)),
      build(:app_environment, environment: build(:environment))
    ]))
  end

  it "renders a list of app_environments" do
    render
    assert_select "tr>td", :text => build(:app).name, :count => 2
    assert_select "tr>td", :text => build(:environment).name, :count => 2
    assert_select "tr>td", :text => build(:app_environment).git_tag, :count => 2
  end
end
