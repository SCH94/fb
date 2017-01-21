class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :first_name, presence: true

  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'friend_requestor_id'
  has_many :requested_friends, through: :sent_friend_requests

  has_many :friend_invitations, class_name: 'FriendRequest', foreign_key: 'requested_friend_id'
  has_many :friend_requestors, through: :friend_invitations

  has_many :friends, foreign_key: 'friender_id'
  has_many :friendees, through: :friends

  has_many :friends, foreign_key: 'friendee_id'
  has_many :frienders, through: :friends


  has_many :posts

  has_many :likes
  has_many :posts_liked, through: :likes, source: :post

  has_many :comments, foreign_key: 'commenter_id'
  has_many :posts_commented, through: :comments, source: :post

  mount_uploader :avatar, AvatarUploader
  
  def fb_friends
    fee = Friend.where friender_id: self.to_param
    frienders = self.frienders
    friendees = fee.map(&:friendee)
    frienders + friendees
  end
end
