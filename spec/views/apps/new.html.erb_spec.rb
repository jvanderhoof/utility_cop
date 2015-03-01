require 'rails_helper'

RSpec.describe "apps/new", type: :view do
  before(:each) do
    assign(:app, App.new(
      :name => "MyString",
      :git_repo => "MyString",
      :language => nil
    ))
  end

  it "renders new app form" do
    render

    assert_select "form[action=?][method=?]", apps_path, "post" do

      assert_select "input#app_name[name=?]", "app[name]"

      assert_select "input#app_git_repo[name=?]", "app[git_repo]"

      assert_select "select#app_language_id[name=?]", "app[language_id]"
    end
  end
end
