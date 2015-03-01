FactoryGirl.define do
  factory :language do
    name "A Language"
  end

  factory :java, class: Language do
    name "Java"
  end

  factory :ruby, class: Language do
    name "Ruby"
  end

end
