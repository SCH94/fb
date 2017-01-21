class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  def home
    @post = Post.new
    @posts = feed
    @comment = Comment.new
  end

  private

    def feed
      unless current_user.fb_friends.empty? && current_user.posts.empty?
        @feed_array = []
        current_user.posts.each do |cp|
          @feed_array << cp
        end
        current_user.fb_friends.each do |fb_friend|
          fb_friend.posts.each do |p|
            @feed_array << p
          end
        end
      @feed_array.sort.reverse
      else
        []
      end
    end

end