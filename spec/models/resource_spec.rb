require 'rails_helper'

RSpec.describe Resource, type: :model do
  it { should belong_to(:language) }
  it { should have_many(:app_resources) }
  it { should have_many(:resource_builds) }

  describe '#ami' do
    context "when ami_id is set locally" do
      it 'returns the local ami' do
        resource = build(:resource, ami_id: '1234567')
        expect(resource.ami).to eq('1234567')
      end
    end
  end
end
