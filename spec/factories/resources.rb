FactoryGirl.define do
  factory :resource do
    name "Resource Name"
    cookbook_url "Cookbook URL"
    language nil
    ami_id 'An AMI'
  end

end
