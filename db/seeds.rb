# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all
User.reset_pk_sequence
Post.reset_pk_sequence
Comment.reset_pk_sequence

fnames = ['Pepe', 'Laura']
lnames = ['Bos', 'Holden']
gender = ['M', 'F']

2.times do |i|
  FactoryGirl.create :user, first_name: fnames[i], last_name: lnames[i], gender: gender[i]
end

20.times do
  FactoryGirl.create :user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, gender: gender[rand 0..1]
end

all = User.all
users = all[2..21]

pepe = User.find_by_first_name 'Pepe'
laura = User.find_by_first_name 'Laura'
pepe_and_laura = [pepe, laura]

define_method (:post) { Faker::Hipster.paragraphs(3).join("\n\n") }
define_method (:comment) { Faker::Hipster.paragraphs(1).first }
define_method (:content_0) { Faker::StarWars.wookie_sentence } 
define_method (:content_1) { Faker::StarWars.quote }
define_method (:content_2) { Faker::Hacker.say_something_smart }
define_method (:content_3) { Faker::Company.catch_phrase }
define_method (:content_4) { Faker::Book.title }
define_method (:content_5) { Faker::ChuckNorris.fact }
define_method (:content_6) { Faker::Beer.yeast }
define_method (:random_content) { [content_0, content_1, content_2, content_3, content_4, content_5, content_6] }
define_method (:mixed) { [comment, random_content[rand 0..6]] }

# Pepe's and Laura's posts
20.times do
  FactoryGirl.create :post, content: post, user: pepe_and_laura[rand 0..1]
end

# Other users' posts
200.times do
  FactoryGirl.create :post, content: mixed[rand 0..1], user: users[rand 0..19]
end

# Comments
3.times do
  220.times do |e|
    FactoryGirl.create :comment, body: mixed[rand 0..1], commenter: all[rand 0..21], post: Post.find(e+1)
  end
end
