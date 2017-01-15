class FriendRequestsController < ApplicationController
  def create
    flash[:notice] = 'Friend request sent.'
    redirect_to root_path
  end
end
