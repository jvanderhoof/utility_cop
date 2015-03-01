FactoryGirl.define do
  factory :resource_build do
    resource nil
    cookbook_version "MyString"
    git_tag "MyString"
    ami_id "MyString"
    current false
  end

end
