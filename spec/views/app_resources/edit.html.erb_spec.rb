require 'rails_helper'

RSpec.describe "app_resources/edit", type: :view do
  before(:each) do
    @app_resource = create(:app_resource, app: build(:app))
  end

  it "renders the edit app_resource form" do
    render

    assert_select "form[action=?][method=?]", app_resource_path(@app_resource), "post" do

      assert_select "input#app_resource_app_id[name=?]", "app_resource[app_id]"

      assert_select "select#app_resource_resource_id[name=?]", "app_resource[resource_id]"
    end
  end
end
