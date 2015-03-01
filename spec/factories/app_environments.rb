FactoryGirl.define do
  factory :app_environment do
    app { build(:app)}
    environment nil
    git_tag "MyString"
  end

end
