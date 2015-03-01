require 'rails_helper'

RSpec.describe "app_environment_resources/new", type: :view do
  before(:each) do
    assign(:app_environment_resource, AppEnvironmentResource.new(
      :app_environment_id => 1,
      :app_resource_id => 1,
      :count => 1,
      :ami_id => "MyString"
    ))
  end

  it "renders new app_environment_resource form" do
    render

    assert_select "form[action=?][method=?]", app_environment_resources_path, "post" do

      assert_select "input#app_environment_resource_app_environment_id[name=?]", "app_environment_resource[app_environment_id]"

      assert_select "input#app_environment_resource_app_resource_id[name=?]", "app_environment_resource[app_resource_id]"

      assert_select "input#app_environment_resource_count[name=?]", "app_environment_resource[count]"

      assert_select "input#app_environment_resource_ami_id[name=?]", "app_environment_resource[ami_id]"
    end
  end
end
