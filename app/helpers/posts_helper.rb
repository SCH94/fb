module PostsHelper
  def post_owner(post)
    post.user_first_name + ' ' + post.user_last_name
  end
end
