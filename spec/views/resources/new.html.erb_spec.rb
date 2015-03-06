require 'rails_helper'

RSpec.describe "resources/new", type: :view do
  before(:each) do
    assign(:resource, Resource.new(
      :name => "MyString",
      :cookbook_url => "MyString",
      :language_id => 1,
      :ami_id => "MyString"
    ))
  end

  it "renders new resource form" do
    render

    assert_select "form[action=?][method=?]", resources_path, "post" do

      assert_select "input#resource_name[name=?]", "resource[name]"

      assert_select "input#resource_cookbook_url[name=?]", "resource[cookbook_url]"

      assert_select "input#resource_language_id[name=?]", "resource[language_id]"

      assert_select "input#resource_ami_id[name=?]", "resource[ami_id]"
    end
  end
end
