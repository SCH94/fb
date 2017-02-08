class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts.latest
    @comment = Comment.new
    @friend_request_to_current_user = @user.sent_friend_requests.where(requested_friend: current_user).first
  end

  def feed
    @posts = Post.latest
    @comment = Comment.new
  end
end
