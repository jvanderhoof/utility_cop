require 'rails_helper'

RSpec.describe Resource, type: :model do
  it { should belong_to(:language) }
  it { should have_many(:app_resources) }
  it { should have_many(:resource_builds) }
end
