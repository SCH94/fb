module FriendRequestsHelper
  def friend_requestor_name(friend_request)
    content_tag :li do
      friend_request.friend_requestor_first_name + ' ' + friend_request.friend_requestor_last_name
    end
  end
end
