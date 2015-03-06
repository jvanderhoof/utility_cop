require 'rails_helper'

RSpec.describe "app_credentials/new", type: :view do
  before(:each) do
    assign(:app_credential, AppCredential.new(
      :credential_id => 1,
      :app_id => 1,
      :encrypted_value => "MyString",
      :text_value => "MyString"
    ))
  end

  it "renders new app_credential form" do
    render

    assert_select "form[action=?][method=?]", app_credentials_path, "post" do

      assert_select "input#app_credential_credential_id[name=?]", "app_credential[credential_id]"

      assert_select "input#app_credential_app_id[name=?]", "app_credential[app_id]"

      assert_select "input#app_credential_encrypted_value[name=?]", "app_credential[encrypted_value]"

      assert_select "input#app_credential_text_value[name=?]", "app_credential[text_value]"
    end
  end
end
