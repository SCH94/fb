class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :comments, dependent: :destroy
  has_many :post_commenters, through: :comments, source: :commenter

  validates :content, presence: true
  validates :user_id, presence: true

  delegate :first_name, :last_name, to: :user, prefix: true

  scope :latest, -> { order(created_at: :desc) }
end
