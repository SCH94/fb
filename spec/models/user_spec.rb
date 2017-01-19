require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user's validity" do
    it 'is a valid user' do
      user = User.new first_name: 'Pepe', last_name: 'Bas', email: 'pepe.bas@example.com', password: 'foobar', password_confirmation: 'foobar'
      expect(user).to be_valid
    end

    it 'is not a valid user without a first name' do
      user = User.new last_name: 'Bas', email: 'pepe.bas@example.com', password: 'foobar', password_confirmation: 'foobar'
      expect(user).not_to be_valid
    end

    it 'is not a valid user without an email' do
      user = User.new first_name: 'Pepe', last_name: 'Bas', password: 'foobar', password_confirmation: 'foobar'
      expect(user).not_to be_valid
    end

    it 'is not a valid user without a password' do
      user = User.new first_name: 'Pepe', last_name: 'Bas', email: 'pepe.bas@example.com'
      expect(user).not_to be_valid
    end
  end

  describe 'facebook friend' do
    let(:user) { create :user }
    it 'returns a bunch of users that were approved as friends' do
      frienders = ['Loren Burgos', 'Lauren Conrad', 'Laura Tarsi']
      3.times do |i|
        user.frienders << instance_variable_set("@#{frienders[i].split.first.downcase}", create(:user, first_name: frienders[i].split.first, last_name: frienders[i].split.last, gender: 'F'))
      end
      expect(user.fb_friends).to contain_exactly(@loren, @lauren, @laura)
    end

    it 'returns a bunch of users that the current user added' do
      friendees = ['Pepe Ignacio', 'Susimo Manalangkal', 'Pedro Penduko']
      3.times do |i|
        instance_variable_set("@#{friendees[i].split.first.downcase}", create(:user, first_name: friendees[i].split.first, last_name: friendees[i].split.last, gender: 'F'))
        instance_variable_get("@#{friendees[i].split.first.downcase}").frienders << user
      end
      expect(user.fb_friends).to contain_exactly(@pepe, @susimo, @pedro)
    end

    it 'returns a bunch of users that were approved and added by the user' do
      frienders = ['Loren Burgos', 'Lauren Conrad', 'Laura Tarsi']
      3.times do |i|
        user.frienders << instance_variable_set("@#{frienders[i].split.first.downcase}", create(:user, first_name: frienders[i].split.first, last_name: frienders[i].split.last, gender: 'F'))
      end

      friendees = ['Pepe Ignacio', 'Susimo Manalangkal', 'Pedro Penduko']
      3.times do |i|
        instance_variable_set("@#{friendees[i].split.first.downcase}", create(:user, first_name: friendees[i].split.first, last_name: friendees[i].split.last, gender: 'F'))
        instance_variable_get("@#{friendees[i].split.first.downcase}").frienders << user
      end

      expect(user.fb_friends).to contain_exactly(@loren, @lauren, @laura, @pepe, @susimo, @pedro) 

    end
  end
end
