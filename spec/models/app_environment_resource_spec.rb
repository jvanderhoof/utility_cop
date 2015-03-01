require 'rails_helper'

RSpec.describe AppEnvironmentResource, type: :model do
  it { should belong_to(:app_environment) }
  it { should belong_to(:app_resource) }
end
