class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate :duplicate

  private

    def duplicate
      return errors.add :base, message: "Can't have two likes for a post." if Like.where(user: self.user, post: self.post).first && self.new_record?
    end
end
