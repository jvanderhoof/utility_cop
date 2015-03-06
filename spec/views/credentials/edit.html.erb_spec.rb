require 'rails_helper'

RSpec.describe "credentials/edit", type: :view do
  before(:each) do
    @credential = assign(:credential, Credential.create!(
      :key_name => "MyString"
    ))
  end

  it "renders the edit credential form" do
    render

    assert_select "form[action=?][method=?]", credential_path(@credential), "post" do

      assert_select "input#credential_key_name[name=?]", "credential[key_name]"
    end
  end
end
