FactoryGirl.define do
  factory :friend_request do
    friend_requestor 
    association :requested_friend, factory: :user, first_name: 'Laura', last_name: 'Best', gender: 'F'
  end
end
