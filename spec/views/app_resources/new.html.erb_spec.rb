require 'rails_helper'

RSpec.describe "app_resources/new", type: :view do
  before(:each) do
    assign(:app_resource, build(:app).app_resources.new)
  end

  it "renders new app_resource form" do
    render

    assert_select "form[action=?][method=?]", app_resources_path, "post" do

      assert_select "input#app_resource_app_id[name=?]", "app_resource[app_id]"

      assert_select "select#app_resource_resource_id[name=?]", "app_resource[resource_id]"

      assert_select "input#app_resource_ami_id[name=?]", "app_resource[ami_id]"
    end
  end
end
