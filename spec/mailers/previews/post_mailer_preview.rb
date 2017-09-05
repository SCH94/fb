# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview

  def new_comment
    PostMailer.new_comment(Comment.last)
  end

end
