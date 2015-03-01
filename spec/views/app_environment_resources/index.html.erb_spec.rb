require 'rails_helper'

RSpec.describe "app_environment_resources/index", type: :view do
  before(:each) do
    assign(:app_environment_resources, [
      AppEnvironmentResource.create!(
        :app_environment_id => 1,
        :app_resource_id => 2,
        :count => 3,
        :ami_id => "Ami"
      ),
      AppEnvironmentResource.create!(
        :app_environment_id => 1,
        :app_resource_id => 2,
        :count => 3,
        :ami_id => "Ami"
      )
    ])
  end

  it "renders a list of app_environment_resources" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Ami".to_s, :count => 2
  end
end
