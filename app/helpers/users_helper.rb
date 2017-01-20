module UsersHelper
  def can_add_user
    current_user != @user 
  end

  def fb_friend?
    current_user.fb_friends.include? @user
  end

  def gender_english(user)
    case user.gender
    when 'M' then 'Male'
    when 'F' then 'Female'
    else 'Not specified'
    end
  end
end
