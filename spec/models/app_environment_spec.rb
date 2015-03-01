require 'rails_helper'

RSpec.describe AppEnvironment, type: :model do
  it { should belong_to(:app) }
  it { should belong_to(:environment) }
  it { should have_many(:app_environment_resources) }
end
