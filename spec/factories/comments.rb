FactoryGirl.define do
  factory :comment do
    body "Let's go out!"
    association :commenter, first_name: 'Loren', last_name: 'Burgos', gender: 'F'
    post
  end
end
