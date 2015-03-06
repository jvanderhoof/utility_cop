require 'rails_helper'

RSpec.describe AppCredential, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:credential) }
  it { should belong_to(:app) }

end
