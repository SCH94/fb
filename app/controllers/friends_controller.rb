class FriendsController < ApplicationController
  rescue_from StandardError, with: :not_friends

  def index
    @user = User.find(params[:user_id])
		@friends = @user.fb_friends
  end

  def create
    @friend_relationship = current_user.accepted_friends.build(friend_relationship_params)
    @friend_request = FriendRequest.where(friend_requestor_id: params[:friender_id], requested_friend_id: current_user.id).first
    @friend_invitations = current_user.friend_invitations # For updating number of friend requests

    respond_to do |format|

      format.js do
        if @friend_relationship.save
          @friend_request.destroy
          render 'users/user_friend_request' if request.referrer == user_url(friend_relationship_params[:friender_id])
        else
          render js: "alert('You are already friends with #{helpers.friender_name @friend_relationship}.');"
          # render 'users/destroy_friend_request' and return if request.referrer == user_url(friend_relationship_params[:friender_id])
          # render 'friend_requests/destroy_friend_is_duplicate'
        end
      end

      format.html do
        if @friend_relationship.save
          @friend_request.destroy
          redirect_back fallback_location: user_friend_requests_path(current_user), notice: "You are now friends with #{helpers.link_to "#{@friend_relationship.friender.first_name} #{@friend_relationship.friender.last_name}", user_path(@friend_relationship.friender)}", flash: { html_safe: true }
        else
          raise StandardError
        end
      end

    end
  end

  def destroy
    if @friend = User.find(params[:friend_id])
      if current_user.frienders.include? @friend
        current_user.frienders.delete @friend
      elsif current_user.friendees.include? @friend
        current_user.friendees.delete @friend
      else
        raise StandardError
      end

      UserMailer.unfriend(current_user, @friend).deliver_later

      respond_to do |format|
        format.js
        format.html { redirect_back fallback_location: root_path, notice: "You are not friends with #{helpers.facebooker(@friend)} anymore." }
      end
    else
      render js: "alert('This user does not exist anymore.');"
    end
  end

  private

    def friend_relationship_params
      params.permit(:friender_id)
    end

    def not_friends
     render '_not_friends' 
    end

end
