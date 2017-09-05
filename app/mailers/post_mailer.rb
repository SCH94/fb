class PostMailer < ApplicationMailer

  def new_comment(comment)
    @comment_body = comment.body
    @post = comment.post
    @commenter = comment.commenter
    @user = @post.user

    mail(to: @user.email, subject: "New comment on your post.")
  end
end
