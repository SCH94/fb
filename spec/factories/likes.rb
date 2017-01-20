FactoryGirl.define do
  factory :like do
    association :user, first_name: 'Loren', last_name: 'Burgos', gender: 'F'
    association :post, content: 'Woohoow'
  end
end
