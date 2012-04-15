class PostMailer < ActionMailer::Base
  default from: "admin@80000hours.org"

  def comment_posted(comment)
    @comment = comment
    @name = comment.post.user.first_name
    mail to: comment.post.user.email, subject: "[80,000 Hours] New comment on #{comment.post.title}"
  end
end
