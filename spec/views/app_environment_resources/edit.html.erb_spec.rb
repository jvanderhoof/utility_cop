require 'rails_helper'

RSpec.describe "app_environment_resources/edit", type: :view do
  before(:each) do
    @app_environment_resource = assign(:app_environment_resource, create(:app_environment_resource,
        app_environment: build(:app_environment, environment: build(:environment)),
        app_resource: build(:app_resource, resource: build(:resource))
      )
    )
  end

  it "renders the edit app_environment_resource form" do
    render

    assert_select "form[action=?][method=?]", app_environment_resource_path(@app_environment_resource), "post" do

      assert_select "input#app_environment_resource_app_environment_id[name=?]", "app_environment_resource[app_environment_id]"

      assert_select "input#app_environment_resource_app_resource_id[name=?]", "app_environment_resource[app_resource_id]"

      assert_select "input#app_environment_resource_count[name=?]", "app_environment_resource[count]"

      assert_select "input#app_environment_resource_ami_id[name=?]", "app_environment_resource[ami_id]"
    end
  end
end
