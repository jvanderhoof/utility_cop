require 'rails_helper'

RSpec.describe "apps/show", type: :view do
  before(:each) do
    @app = assign(:app, App.create!(
      :name => "Name",
      :git_repo => "Git Repo",
      :language => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Git Repo/)
    expect(rendered).to match(//)
  end
end
