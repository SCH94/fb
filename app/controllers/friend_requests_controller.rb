class FriendRequestsController < ApplicationController
   # rescue_from ActiveRecord::RecordInvalid, with: :show_errors

  def index
    @friend_requests = current_user.friend_invitations
  end

  def create
    friend_request = current_user.sent_friend_requests.build(friend_requests_params)
    user = User.find(friend_requests_params[:requested_friend_id])
    if friend_request.save
      flash[:notice] = 'Friend request sent.'
      redirect_to root_path
    else
      redirect_to user, alert: friend_request.errors.full_messages.first[:message]
    end
  end

  def destroy
    fr = FriendRequest.find(params[:id])
    fr.destroy
    redirect_to user_friend_requests_path(current_user), notice: 'Deleted friend request by Loren Burgos'
  end

  private

    def friend_requests_params
      params.permit(:requested_friend_id)
    end

end
