require 'rails_helper'

RSpec.describe "app_environments/show", type: :view do
  before(:each) do
    @app_environment = assign(:app_environment, create(:app_environment, app: create(:app), environment: create(:environment)))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(build(:app).name)
    expect(rendered).to match(build(:environment).name)
    expect(rendered).to match(build(:app_environment).git_tag)
  end
end
