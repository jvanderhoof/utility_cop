require 'rails_helper'

RSpec.describe "vpcs/show", type: :view do
  before(:each) do
    @vpc = assign(:vpc, Vpc.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
