require 'rails_helper'

RSpec.describe "app_environment_resources/show", type: :view do
  before(:each) do
    @app_environment_resource = assign(:app_environment_resource, AppEnvironmentResource.create!(
      :app_environment_id => 1,
      :app_resource_id => 2,
      :count => 3,
      :ami_id => "Ami"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Ami/)
  end
end
