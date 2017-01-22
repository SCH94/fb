# helpers for user resource in views
module UsersHelper

  def facebooker_current_user?(user)
    current_user == user
  end

  def fb_friend?(user)
    current_user.fb_friends.include? user
  end

  def gender_english(user)
    case user.gender
    when 'M' then 'Male'
    when 'F' then 'Female'
    else 'Not specified'
    end
  end

  def facebooker(user)
    user.first_name + ' ' + user.last_name
  end
end
