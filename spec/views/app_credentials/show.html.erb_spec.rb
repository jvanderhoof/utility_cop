require 'rails_helper'

RSpec.describe "app_credentials/show", type: :view do
  before(:each) do
    @app_credential = assign(:app_credential, AppCredential.create!(
      :credential_id => 1,
      :app_id => 2,
      :encrypted_value => "Encrypted Value",
      :text_value => "Text Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Encrypted Value/)
    expect(rendered).to match(/Text Value/)
  end
end
