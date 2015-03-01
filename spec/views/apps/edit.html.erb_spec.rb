require 'rails_helper'

RSpec.describe "apps/edit", type: :view do
  before(:each) do
    @app = assign(:app, App.create!(
      :name => "MyString",
      :git_repo => "MyString",
      :language => nil
    ))
  end

  it "renders the edit app form" do
    render

    assert_select "form[action=?][method=?]", app_path(@app), "post" do

      assert_select "input#app_name[name=?]", "app[name]"

      assert_select "input#app_git_repo[name=?]", "app[git_repo]"

      assert_select "select#app_language_id[name=?]", "app[language_id]"
    end
  end
end
