class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :first_name, presence: true

  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'friend_requestor_id'
  has_many :friendees, through: :sent_friend_requests, source: :requested_friend

  has_many :friend_invitations, class_name: 'FriendRequest', foreign_key: 'requested_friend_id'
  has_many :frienders, through: :friend_invitations, source: :friend_requestor

  has_many :friends, foreign_key: 'friender_id'
  has_many :friendees, through: :friends

  has_many :friends, foreign_key: 'friendee_id'
  has_many :frienders, through: :friends

  has_many :posts

  has_many :likes
  has_many :posts_liked, through: :likes, source: :post

  def fb_friends
    fee = Friend.where friender_id: self.to_param
    frienders = self.frienders
    friendees = fee.map(&:friendee)
    frienders + friendees
  end
end
