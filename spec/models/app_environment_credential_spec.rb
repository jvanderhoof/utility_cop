require 'rails_helper'

RSpec.describe AppEnvironmentCredential, type: :model do
  it { should belong_to(:app_environment) }
  it { should belong_to(:credential) }

end
