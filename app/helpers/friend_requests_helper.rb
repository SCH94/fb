module FriendRequestsHelper
  def friend_requestor_name(friend_request)
    # content_tag :li do
    friend_request.friend_requestor_first_name + ' ' + friend_request.friend_requestor_last_name
    # end
  end

  def requested_friend_name(friend_request)
    # content_tag :li do
    friend_request.requested_friend_first_name + ' ' + friend_request.requested_friend_last_name
    # end
  end

  def request_sent?(user)
    current_user.requested_friends.include? user
  end

  def requested_by?(user)
    current_user.friend_requestors.include? user
  end
end
