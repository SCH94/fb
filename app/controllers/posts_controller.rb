class PostsController < ApplicationController
  before_action :own_post?, only: :destroy

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to current_user, notice: 'Post deleted.' and return if request.referrer == post_url
    redirect_back fallback_location: current_user, notice: 'Post deleted.'
  end

  private

    def own_post?
      post = Post.find(params[:id])
      return if current_user.posts.include? post
      sign_out_and_redirect current_user
      flash[:notice] = 'You are not authorized to do that action.'
    end
end
