FactoryGirl.define do
  factory :user, aliases: [:friend_requestor, :requested_friend] do
    first_name 'Pepe'
    last_name 'Bas'
    username { "#{first_name.split.first}".downcase } 
    email { "#{first_name.split.first}.#{last_name}@example.com" }
		password 'foobar'
		password_confirmation 'foobar'
    gender 'M'
  end
end
