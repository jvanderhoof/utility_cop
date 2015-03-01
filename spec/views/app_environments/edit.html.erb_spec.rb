require 'rails_helper'

RSpec.describe "app_environments/edit", type: :view do
  before(:each) do
    @app_environment = create(:app_environment, app: build(:app))
  end

  it "renders the edit app_environment form" do
    render

    assert_select "form[action=?][method=?]", app_environment_path(@app_environment), "post" do

      assert_select "input#app_environment_app_id[name=?]", "app_environment[app_id]"

      assert_select "select#app_environment_environment_id[name=?]", "app_environment[environment_id]"

      assert_select "input#app_environment_git_tag[name=?]", "app_environment[git_tag]"
    end
  end
end
