FactoryGirl.define do
  factory :app do
    name "My App Name"
    git_repo "git@github.com:some-username/some-project.git"
    language
  end

end
