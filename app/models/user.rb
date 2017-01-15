class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :first_name, presence: true

  has_many :friend_requests, foreign_key: 'friend_requestor_id'
  has_many :friendees, through: :friend_requests, source: :requested_friend

  has_many :friend_requests, foreign_key: 'requested_friend_id'
  has_many :frienders, through: :friend_requests, source: :friend_requestor
end
