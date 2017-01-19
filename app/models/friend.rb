class Friend < ApplicationRecord
  belongs_to :friender, class_name: 'User'
  belongs_to :friendee, class_name: 'User'

  validates_presence_of :friender_id, :friendee_id
  validate :duplicate

  private

    def duplicate
      return errors.add :base, message: 'Friend already exists.' if self.new_record? && Friend.where(friender_id: self.friender_id, friendee_id: self.friendee_id).first
    end
end
