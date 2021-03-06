class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Efbook! :)')
  end

  def unfriend(current_user, user)
    @current_user = current_user
    @user = user
    mail(to: @user.email, subject: 'A user has unfriended you')
  end

  def new_signup(user)
    @user = user
    mail(to: 'frpine@outlook.com', subject: "#{user.first_name + ' ' + user.last_name} has signed up!")
  end
end
