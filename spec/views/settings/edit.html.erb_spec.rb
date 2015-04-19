require 'rails_helper'

RSpec.describe "settings/edit", type: :view do
  before(:each) do
    @setting = assign(:setting, Setting.create!(
      :key => "MyString",
      :value => "MyString",
      :app_id => 1
    ))
  end

  it "renders the edit setting form" do
    render

    assert_select "form[action=?][method=?]", setting_path(@setting), "post" do

      assert_select "input#setting_key[name=?]", "setting[key]"

      assert_select "input#setting_value[name=?]", "setting[value]"

      assert_select "input#setting_app_id[name=?]", "setting[app_id]"
    end
  end
end
