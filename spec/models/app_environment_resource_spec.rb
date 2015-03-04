require 'rails_helper'

RSpec.describe AppEnvironmentResource, type: :model do
  it { should belong_to(:app_environment) }
  it { should belong_to(:app_resource) }


  describe '#ami' do
    context "when ami_id is set locally" do
      it 'returns the local ami' do
        aer = build(:app_environment_resource, ami_id: '1234567')
        expect(aer.ami).to eq('1234567')
      end
    end

    context 'when ami_id is not present it should use parent ami_id' do
      it 'returns the parent ami' do
        aer = build(:app_environment_resource, ami_id: nil, app_resource: build(:app_resource, ami_id: 'parent_ami'))
        expect(aer.ami).to eq('parent_ami')
      end
    end
  end

end
