require 'rails_helper'

RSpec.describe "apps/index", type: :view do
  before(:each) do
    assign(:apps, [
      App.create!(
        :name => "Name",
        :git_repo => "Git Repo",
        :language => nil
      ),
      App.create!(
        :name => "Name",
        :git_repo => "Git Repo",
        :language => nil
      )
    ])
  end

  it "renders a list of apps" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Git Repo".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
