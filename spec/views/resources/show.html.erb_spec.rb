require 'rails_helper'

RSpec.describe "resources/show", type: :view do
  before(:each) do
    @resource = assign(:resource, create(:resource, language: build(:language)))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(build(:resource).name)
    expect(rendered).to match(build(:resource).cookbook_url)
    expect(rendered).to match(build(:language).name)
    expect(rendered).to match(build(:resource).ami_id)
  end
end
