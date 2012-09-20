class DiscussionPostMailer < ActionMailer::Base
  default :from => 'admin@80000hours.org',
          :return_path => 'admin@80000hours.org'

  def new_comment(comment)
    @email = comment.post_author_email

    if @email
      @comment = comment
      @commenter_name = (@comment.user ? comment.user.first_name : comment.name)

      @comment_post_title = comment.discussion_post.title
      @comment_post_url = discussion_post_url(comment.discussion_post)

      mail(:to => comment.discussion_post.user.email,
           :subject => "[80,000 Hours - Discussion] New comment on #{comment.discussion_post.title}"
      )
    end
  end
end
