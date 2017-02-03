class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
		@friends = @user.fb_friends
  end

  def create
    friend_relationship = current_user.friends.build(friend_relationship_params)
    if friend_relationship.save
      friend_request = FriendRequest.where(friend_requestor_id: params[:friender_id], requested_friend_id: current_user.id).first
      friend_request.destroy
      redirect_back fallback_location: user_friend_requests_path(current_user), notice: "You are now friends with #{helpers.link_to "#{friend_relationship.friender.first_name} #{friend_relationship.friender.last_name}", user_path(friend_relationship.friender)}", flash: { html_safe: true }
    else
      raise StandardError
    end
  end

  private

    def friend_relationship_params
      params.permit(:friender_id)
    end
end
