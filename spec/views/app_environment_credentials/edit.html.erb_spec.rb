require 'rails_helper'

RSpec.describe "app_environment_credentials/edit", type: :view do
  before(:each) do
    @app_environment_credential = assign(:app_environment_credential, AppEnvironmentCredential.create!(
      :credential_id => 1,
      :app_environment_id => 1,
      :encrypted_value => "MyString",
      :text_value => "MyString"
    ))
  end

  it "renders the edit app_environment_credential form" do
    render

    assert_select "form[action=?][method=?]", app_environment_credential_path(@app_environment_credential), "post" do

      assert_select "input#app_environment_credential_credential_id[name=?]", "app_environment_credential[credential_id]"

      assert_select "input#app_environment_credential_app_environment_id[name=?]", "app_environment_credential[app_environment_id]"

      assert_select "input#app_environment_credential_encrypted_value[name=?]", "app_environment_credential[encrypted_value]"

      assert_select "input#app_environment_credential_text_value[name=?]", "app_environment_credential[text_value]"
    end
  end
end
