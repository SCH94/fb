FactoryGirl.define do
  factory :user, aliases: [:friend_requestor, :friendee] do
    first_name 'Pepe'
    last_name 'Bas'
    username { "#{first_name.split.first}".downcase } 
    email { "#{first_name.split.first}.#{last_name}@example.com" }
		password 'foobar'
		password_confirmation 'foobar'
    gender 'M'

    factory :user_with_posts do
      transient do
        post_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.post_count, content: Faker::Hipster.paragraph, user: user)
      end
    end
  end
end
