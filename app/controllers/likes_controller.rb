class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.posts_liked << @post
    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.where(post: @post).first
    respond_to do |format|
      format.js { like.destroy }
      format.html { redirect_back fallback_location: root_path if like.destroy }
    end
  end

end
