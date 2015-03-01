require 'rails_helper'

RSpec.describe ResourceBuild, type: :model do
  it { should belong_to(:resource) }
end
