class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  def home
    @post = Post.new
    @posts = Post.latest
  end
end
