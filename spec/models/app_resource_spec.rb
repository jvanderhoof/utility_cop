require 'rails_helper'

RSpec.describe AppResource, type: :model do
  it { should belong_to(:resource) }
  it { should belong_to(:app) }
  it { should have_many(:app_environment_resources) }
end
