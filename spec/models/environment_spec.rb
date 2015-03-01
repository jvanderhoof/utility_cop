require 'rails_helper'

RSpec.describe Environment, type: :model do
  it { should have_many(:app_environments) }

end
