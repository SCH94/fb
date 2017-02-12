module FriendsHelper
  def friender_name(friend_relationship)
    friend_relationship.friender_first_name + " " + friend_relationship.friender_last_name
  end
end
