class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_back fallback_location: root_path, notice: "Commented on #{helpers.link_to 'post', post}", flash: { html_safe: true }
    else
      redirect_back fallback_location: root_path, notice: "Can't have blank comment."
    end
  end

  private

    def comment_params
      { body: params[:comment][:body], post_id: params[:post_id] }
    end
end
