require 'rails_helper'

RSpec.describe "credentials/show", type: :view do
  before(:each) do
    @credential = assign(:credential, Credential.create!(
      :key_name => "Key Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key Name/)
  end
end
