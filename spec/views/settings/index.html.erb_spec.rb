require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        :key => "Key",
        :value => "Value",
        :app_id => 1
      ),
      Setting.create!(
        :key => "Key",
        :value => "Value",
        :app_id => 1
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
