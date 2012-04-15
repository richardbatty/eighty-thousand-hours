class PostMailer < ActionMailer::Base
  default from: "admin@80000hours.org"

  def new_comment(comment)
    @comment = comment
    if @comment.post.user
      @name = comment.post.user.first_name
      mail to: [comment.post.user.email, 'admin@80000hours.org'], subject: "[80,000 Hours] New comment on #{comment.post.title}"
    end
  end
end
