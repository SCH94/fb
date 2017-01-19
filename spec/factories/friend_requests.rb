FactoryGirl.define do
  factory :friend_request do
    friend_requestor 
    association :requested_friend, factory: :user, first_name: 'Loren', last_name: 'Burgos', gender: 'F'
  end
end
