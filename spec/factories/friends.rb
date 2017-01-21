FactoryGirl.define do
  factory :friend do
    association :friender, factory: :user, first_name: 'Loren', last_name: 'Burgos', gender: 'F'
    friendee
  end
end
