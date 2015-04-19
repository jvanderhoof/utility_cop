require 'rails_helper'

RSpec.describe "settings/new", type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      :key => "MyString",
      :value => "MyString",
      :app_id => 1
    ))
  end

  it "renders new setting form" do
    render

    assert_select "form[action=?][method=?]", settings_path, "post" do

      assert_select "input#setting_key[name=?]", "setting[key]"

      assert_select "input#setting_value[name=?]", "setting[value]"

      assert_select "input#setting_app_id[name=?]", "setting[app_id]"
    end
  end
end
