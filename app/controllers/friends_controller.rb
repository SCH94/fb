class FriendsController < ApplicationController
  rescue_from StandardError, with: :show_error

  def index
		@friends = current_user.fb_friends
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

    def show_error
      render file: 'public/500', layout: false
    end
end
