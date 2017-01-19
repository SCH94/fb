class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  def home
    @post = current_user.posts.build
  end
end
