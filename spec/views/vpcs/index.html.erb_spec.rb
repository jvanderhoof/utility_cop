require 'rails_helper'

RSpec.describe "vpcs/index", type: :view do
  before(:each) do
    assign(:vpcs, [
      Vpc.create!(
        :name => "Name"
      ),
      Vpc.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of vpcs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
