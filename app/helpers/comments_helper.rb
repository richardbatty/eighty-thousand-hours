module CommentsHelper
  def comment_post_path(comment)
    if comment.blog_post_id.nil? and comment.discussion_post_id.nil?
      return
    end

    if comment.blog_post_id.nil?
      discussion_post_path( comment.discussion_post )
    else
      blog_post_path( comment.blog_post )
    end
  end

  def link_to_comment_author( comment )
    if comment.user
      link_to comment.user.name, user_path( comment.user )
    else
      link_to comment.name, (comment_post_path( comment ) + "#comments")
    end
  end

  def link_to_comment_author_and_title( comment )
    link_to_comment_author( comment ) + "<br/>in ".html_safe + link_to_blog_post_contents( comment.blog_post )
  end

  def link_to_comment_contents(comment,length=35)
    link_to(truncate(comment.body, length: length), (comment_post_path( comment ) + "#comments"))
  end
end
