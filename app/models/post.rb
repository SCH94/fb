class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :content, presence: true
  validates :user_id, presence: true

  delegate :first_name, :last_name, to: :user, prefix: true

  scope :latest, -> { order(created_at: :desc) }
end
