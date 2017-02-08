class Friend < ApplicationRecord
  belongs_to :friender, class_name: 'User'
  belongs_to :friendee, class_name: 'User'

  validates_presence_of :friender_id, :friendee_id
  validate :duplicate

  private

    def duplicate
      return errors.add :base, message: 'Friend already exists.' if self.new_record? && friend_relationship_duplicate
    end

    def friend_relationship_duplicate
      Friend.where(friender_id: self.friender_id, friendee_id: self.friendee_id).first || Friend.where(friender_id: self.friendee_id, friendee_id: self.friender_id).first
    end
end
