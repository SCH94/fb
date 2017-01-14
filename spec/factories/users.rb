FactoryGirl.define do
  factory :user do
    first_name 'Pepe'
    last_name 'Bas'
    username 'pepe'
    gender 'M'
    email 'pepe.bas@example.com'
		password 'foobar'
		password_confirmation 'foobar'
  end
end
