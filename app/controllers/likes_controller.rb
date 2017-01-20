class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    if current_user.posts_liked.include? post
      like_to_destroy = current_user.likes.where(post: post).first
      like_to_destroy.destroy
      redirect_back fallback_location: root_path
    else
      current_user.posts_liked << post
      redirect_back fallback_location: root_path
    end
  end

end
