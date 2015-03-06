require 'rails_helper'

RSpec.describe "app_credentials/edit", type: :view do
  before(:each) do
    @app_credential = assign(:app_credential, AppCredential.create!(
      :credential_id => 1,
      :app_id => 1,
      :encrypted_value => "MyString",
      :text_value => "MyString"
    ))
  end

  it "renders the edit app_credential form" do
    render

    assert_select "form[action=?][method=?]", app_credential_path(@app_credential), "post" do

      assert_select "input#app_credential_credential_id[name=?]", "app_credential[credential_id]"

      assert_select "input#app_credential_app_id[name=?]", "app_credential[app_id]"

      assert_select "input#app_credential_encrypted_value[name=?]", "app_credential[encrypted_value]"

      assert_select "input#app_credential_text_value[name=?]", "app_credential[text_value]"
    end
  end
end
