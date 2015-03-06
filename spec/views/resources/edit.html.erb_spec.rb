require 'rails_helper'

RSpec.describe "resources/edit", type: :view do
  before(:each) do
    @resource = assign(:resource, create(:resource))
  end

  it "renders the edit resource form" do
    render

    assert_select "form[action=?][method=?]", resource_path(@resource), "post" do

      assert_select "input#resource_name[name=?]", "resource[name]"

      assert_select "input#resource_cookbook_url[name=?]", "resource[cookbook_url]"

      assert_select "input#resource_language_id[name=?]", "resource[language_id]"

      assert_select "input#resource_ami_id[name=?]", "resource[ami_id]"
    end
  end
end
