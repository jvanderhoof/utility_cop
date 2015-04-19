require 'rails_helper'

RSpec.describe "settings/show", type: :view do
  before(:each) do
    @setting = assign(:setting, Setting.create!(
      :key => "Key",
      :value => "Value",
      :app_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(/1/)
  end
end
