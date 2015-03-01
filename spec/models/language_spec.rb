require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should have_many(:resources) }
  it { should have_many(:apps) }

  describe "default order" do
    let(:lang_1) { create(:language, name: 'Ruby') }
    let(:lang_2) { create(:language, name: 'Java') }

    it { expect(Language.all).to eq([lang_2, lang_1]) }
  end
end
