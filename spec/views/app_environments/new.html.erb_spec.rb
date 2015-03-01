require 'rails_helper'

RSpec.describe "app_environments/new", type: :view do
  before(:each) do
    assign(:app_environment, build(:app).app_environments.new)
  end

  it "renders new app_environment form" do
    render

    assert_select "form[action=?][method=?]", app_environments_path, "post" do

      assert_select "input#app_environment_app_id[name=?]", "app_environment[app_id]"

      assert_select "select#app_environment_environment_id[name=?]", "app_environment[environment_id]"

      assert_select "input#app_environment_git_tag[name=?]", "app_environment[git_tag]"
    end
  end
end
