# Sending friend requests
class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_invitations = current_user.friend_invitations # update test
    @sent_friend_requests = current_user.sent_friend_requests # to test
  end

  def create
    friend_request = current_user.sent_friend_requests.build(friend_requests_params)
    user = User.find(friend_requests_params[:requested_friend_id])
    if friend_request.save
      if request.referrer == users_url
        redirect_back fallback_location: root_path, notice: "Friend request sent to #{helpers.link_to helpers.facebooker(user), user_path(user)}", flash: { html_safe: true }
      elsif request.referrer == user_url(user)
        redirect_back fallback_location: root_path, notice: 'Friend request sent.'
      end
    else
      redirect_to user, alert: friend_request.errors.full_messages.first[:message]
    end
  end

  def destroy
    fr = FriendRequest.find(params[:id])
    fr.destroy
    if fr.friend_requestor != current_user
      redirect_to user_friend_requests_path(current_user), notice: "Deleted received friend request by #{helpers.link_to helpers.friend_requestor_name(fr), fr.friend_requestor}", flash: { html_safe: true }
    else
      redirect_to user_friend_requests_path(current_user), notice: "Deleted sent friend request to #{helpers.link_to helpers.requested_friend_name(fr), fr.requested_friend}", flash: { html_safe: true }
    end
  end

  private

    def friend_requests_params
      params.permit(:requested_friend_id)
    end

end
