class PostsController < ApplicationController
  before_action :own_post?, only: :destroy

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @comment = Comment.new
    respond_to do |format|
      format.js { @post.save }
      format.html do
        redirect_back fallback_location: root_path, notice: 'Post created' and return if @post.save
        redirect_back fallback_location: root_path, notice: @post.errors.full_messages.first
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js { @post.destroy }
      format.html do
        @post.destroy
        redirect_to current_user, notice: 'Post deleted.' and return if request.referrer == post_url
        redirect_back fallback_location: current_user, notice: 'Post deleted.'
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

    def own_post?
      post = Post.find(params[:id])
      return if current_user.posts.include? post
      sign_out_and_redirect current_user
      flash[:notice] = 'You are not authorized to do that action.'
    end
end
