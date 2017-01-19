module UsersHelper
  def can_add_user
    current_user != @user 
  end

  def fb_friend?
    current_user.fb_friends.include? @user
  end
end
