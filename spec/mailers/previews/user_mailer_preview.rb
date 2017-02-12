# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def unfriend
    UserMailer.unfriend(User.second, User.first)
  end

  def new_signup
    UserMailer.new_signup(User.first)
  end
end
