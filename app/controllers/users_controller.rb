class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts.latest
    @comment = Comment.new
  end
end
