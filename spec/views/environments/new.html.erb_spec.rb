require 'rails_helper'

RSpec.describe "environments/new", type: :view do
  before(:each) do
    assign(:environment, Environment.new(
      :name => "MyString"
    ))
  end

  it "renders new environment form" do
    render

    assert_select "form[action=?][method=?]", environments_path, "post" do

      assert_select "input#environment_name[name=?]", "environment[name]"
    end
  end
end
