class BlogPostMailer < ActionMailer::Base
  default :from => 'admin@80000hours.org',
          :return_path => 'admin@80000hours.org'

  def new_comment(comment)
    @post_author = comment.blog_post.user.name

    @comment = comment
    @commenter_name = (@comment.user ? comment.user.first_name : comment.name)

    @comment_post_title = comment.blog_post.title
    @comment_post_url = blog_post_url(comment.blog_post)

    mail(:to => comment.blog_post.user.email,
         :subject => "[80,000 Hours] New comment on #{comment.blog_post.title}"
    )
  end
end
