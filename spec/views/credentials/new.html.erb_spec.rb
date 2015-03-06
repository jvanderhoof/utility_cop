require 'rails_helper'

RSpec.describe "credentials/new", type: :view do
  before(:each) do
    assign(:credential, Credential.new(
      :key_name => "MyString"
    ))
  end

  it "renders new credential form" do
    render

    assert_select "form[action=?][method=?]", credentials_path, "post" do

      assert_select "input#credential_key_name[name=?]", "credential[key_name]"
    end
  end
end
