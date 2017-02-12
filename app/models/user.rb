class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, presence: true

  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'friend_requestor_id', dependent: :destroy
  has_many :requested_friends, through: :sent_friend_requests

  has_many :friend_invitations, class_name: 'FriendRequest', foreign_key: 'requested_friend_id', dependent: :destroy
  has_many :friend_requestors, through: :friend_invitations

  has_many :sought_friends, class_name: 'Friend', foreign_key: 'friender_id', dependent: :destroy
  has_many :friendees, through: :sought_friends

  has_many :accepted_friends, class_name: 'Friend', foreign_key: 'friendee_id', dependent: :destroy
  has_many :frienders, through: :accepted_friends


  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :posts_liked, through: :likes, source: :post

  has_many :comments, foreign_key: 'commenter_id', dependent: :destroy
  has_many :posts_commented, through: :comments, source: :post

  mount_uploader :avatar, AvatarUploader
  
  def fb_friends
    frienders + friendees
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split[0..-2].join(' ')
      user.last_name = auth.info.name.split.last
      user.username = auth.info.name.split.first.downcase
      user.remote_avatar_url = auth.info.image
      user.save
      UserMailer.welcome_email(user).deliver_later
      UserMailer.new_signup(user).deliver_later
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data['name'].split[0..-2].join(' ')
        user.last_name = data['name'].split.last
        user.username = data['name'].split.first.downcase
      end
    end
  end
end
