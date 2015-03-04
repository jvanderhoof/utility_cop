require 'rails_helper'

RSpec.describe AppResource, type: :model do
  it { should belong_to(:resource) }
  it { should belong_to(:app) }
  it { should have_many(:app_environment_resources) }

  describe '#ami' do
    context "when ami_id is set locally" do
      it 'returns the local ami' do
        ar = build(:app_resource, ami_id: '1234567')
        expect(ar.ami).to eq('1234567')
      end
    end

    context 'when ami_id is not present it should use parent ami_id' do
      it 'returns the parent ami' do
        ar = build(:app_resource, ami_id: nil, resource: build(:resource, ami_id: 'parent_ami'))
        expect(ar.ami).to eq('parent_ami')
      end
    end
  end


end
