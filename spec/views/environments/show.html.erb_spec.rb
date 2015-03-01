require 'rails_helper'

RSpec.describe "environments/show", type: :view do
  before(:each) do
    @environment = assign(:environment, Environment.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
