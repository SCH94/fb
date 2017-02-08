module PostsHelper
  def post_owner(post)
    post.user_first_name + ' ' + post.user_last_name
  end

  def nl2br(text)
    text.gsub(/\n/, '<br>')
  end
end
