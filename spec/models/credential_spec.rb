require 'rails_helper'

RSpec.describe Credential, type: :model do
  it { should have_many(:app_credentials) }
  it { should have_many(:app_environment_credentials) }

end
