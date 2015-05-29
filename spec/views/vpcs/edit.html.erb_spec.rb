require 'rails_helper'

RSpec.describe "vpcs/edit", type: :view do
  before(:each) do
    @vpc = assign(:vpc, Vpc.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit vpc form" do
    render

    assert_select "form[action=?][method=?]", vpc_path(@vpc), "post" do

      assert_select "input#vpc_name[name=?]", "vpc[name]"
    end
  end
end
