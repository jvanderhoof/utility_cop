require 'rails_helper'

RSpec.describe "resources/index", type: :view do
  before(:each) do
    @language = create(:language)
    assign(:resources, [
      create(:resource, language: @language),
      create(:resource, language: @language)
    ])
  end

  it "renders a list of resources" do
    render
    assert_select "tr>td", :text => build(:resource).name, :count => 2
    assert_select "tr>td", :text => build(:resource).cookbook_url, :count => 2
    assert_select "tr>td", :text => @language.name, :count => 2
    assert_select "tr>td", :text => build(:resource).ami_id, :count => 2
  end
end
