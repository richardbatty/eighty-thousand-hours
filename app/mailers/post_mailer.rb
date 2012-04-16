class PostMailer < ActionMailer::Base
  default from: "admin@80000hours.org"

  def new_comment(comment)
    # only try and send an email if a User owns the post
    # and don't email if author commenting on their own post
    if comment.post.user && (comment.post.user != comment.user)
      @post_author = comment.post.user.name
      @post_author_email = comment.post.user.email

      @comment = comment
      @commenter_name = (@comment.user ? comment.user.first_name : comment.name)

      mail to: [@post_author_email, 'admin@80000hours.org'], subject: "[80,000 Hours] New comment on #{comment.post.title}"
    end
  end
end
