module DiscussionPostsHelper
  def link_to_discussion_post_author( post )
    if post.user
      link_to post.user.name, user_path( post.user )
    else
      link_to post.name, (discussion_post_path( post ))
    end
  end
end