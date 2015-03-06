require 'rails_helper'

RSpec.describe "app_environment_credentials/index", type: :view do
  before(:each) do
    assign(:app_environment_credentials, [
      AppEnvironmentCredential.create!(
        :credential_id => 1,
        :app_environment_id => 2,
        :encrypted_value => "Encrypted Value",
        :text_value => "Text Value"
      ),
      AppEnvironmentCredential.create!(
        :credential_id => 1,
        :app_environment_id => 2,
        :encrypted_value => "Encrypted Value",
        :text_value => "Text Value"
      )
    ])
  end

  it "renders a list of app_environment_credentials" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Encrypted Value".to_s, :count => 2
    assert_select "tr>td", :text => "Text Value".to_s, :count => 2
  end
end
