class CommentsController < ApplicationController
  before_action :correct_comment_owner, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      format.js { @comment.save }
      format.html do
        if @comment.save
          redirect_back fallback_location: root_path, notice: "Commented on #{helpers.link_to 'post', @post}", flash: { html_safe: true }
        else
          redirect_back fallback_location: root_path, notice: "Can't have blank comment."
        end
      end
    end

  end

  def destroy
    respond_to do |format|
      format.js { @comment.destroy } 
      format.html { redirect_back fallback_location: root_path, notice: 'Comment deleted' and return if @comment.destroy }
    end
  end

  private

    def comment_params
      { body: params[:comment][:body], post_id: params[:post_id] }
    end

    def correct_comment_owner
      @comment = Comment.find(params[:id])
      unless @comment.commenter == current_user
        respond_to do |format|
          format.js { render 'correct_comment_owner' } 
          format.html { redirect_back fallback_location: root_path, notice: "Not allowed to delete other's post." } 
        end
      end
    end
end
