FactoryGirl.define do
  factory :app_resource do
    app { build(:app)}
    resource nil
  end

end
