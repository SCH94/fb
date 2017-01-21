module CommentsHelper
  def commenter(comment)
    comment.commenter_first_name + ' ' + comment.commenter_last_name
  end
end
