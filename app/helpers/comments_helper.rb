module CommentsHelper
  def comment_post_path(comment)
    if comment.post.category == "blog"
      post_path( comment.post )
    else
      "/discussion/#{comment.post.slug}"
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
    link_to_comment_author( comment ) + "<br/>in ".html_safe + link_to_post_contents( comment.post )
  end

  def link_to_comment_contents(comment,length=35)
    link_to(truncate(comment.body, length: length), (comment_post_path( comment ) + "#comments"))
  end
end
