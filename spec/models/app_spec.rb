require 'rails_helper'

RSpec.describe App, type: :model do
  it { should belong_to(:language) }
  it { should have_many(:app_resources) }
  it { should have_many(:app_environments) }
end
