class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :post

  validates_presence_of :body, :commenter_id, :post_id

  delegate :first_name, :last_name, to: :commenter, prefix: true
    
end
