require 'rails_helper'

RSpec.describe "credentials/index", type: :view do
  before(:each) do
    assign(:credentials, [
      Credential.create!(
        :key_name => "Key Name"
      ),
      Credential.create!(
        :key_name => "Key Name"
      )
    ])
  end

  it "renders a list of credentials" do
    render
    assert_select "tr>td", :text => "Key Name".to_s, :count => 2
  end
end
