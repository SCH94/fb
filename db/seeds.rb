# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.reset_pk_sequence
Post.reset_pk_sequence
Comment.reset_pk_sequence

fnames = ['Pepe', 'Laura']
lnames = ['Bas', 'Tarsi']
gender = ['M', 'F']

2.times do |i|
  FactoryGirl.create :user, first_name: fnames[i], last_name: lnames[i], gender: gender[i]
end

3.times do
  FactoryGirl.create :user, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, gender: 'F'
end

user3 = User.third
user4 = User.fourth
user5 = User.fifth
users = [user3, user4, user5]

pepe = User.find_by_first_name 'Pepe'
laura = User.find_by_first_name 'Laura'
pepelaura = [pepe, laura]

# Pepe's and Laura's posts
20.times do
  FactoryGirl.create :post, content: Faker::Hipster.paragraphs(3), user: pepelaura[rand 0..1]
end

# Comments
3.times do
  20.times do |e|
    FactoryGirl.create :comment, body: Faker::Hipster.paragraphs(1), commenter: users[rand 0..2], post: Post.find(e+1)
  end
end
