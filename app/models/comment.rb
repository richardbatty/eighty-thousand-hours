class Comment < ActiveRecord::Base
  validates_presence_of :body,    message: "can't be blank"

  # should check we have either blog_post_id *OR* discussion_post_id
  #validates_presence_of :post_id

  attr_accessor :email_confirmation

  before_save :either_user_or_email
  before_validation :check_honeypot

  belongs_to :user
  belongs_to :blog_post
  belongs_to :discussion_post

  scope :blog, where(:blog_post_id != nil)

  def get_name
    user ? user.name : name
  end

  def post_author_email
    if discussion_post
      discussion_post.user.email
    else
      if blog_post.user
        blog_post.user.email
      else
        # blog post is by guest w. no email
        nil
      end
    end
  end

  def title
    if discussion_post
      discussion_post.title
    else
      blog_post.title
    end
  end

  def post
    if discussion_post
      discussion_post
    else
      blog_post
    end
  end

  private
  def check_honeypot
    email_confirmation.blank?
  end

  def either_user_or_email
    result = true
    if self.user.nil?
      if self.name.blank?
        errors.add(:name, "can't be blank" )
        result = false
      end
      if self.email.blank?
        errors.add(:email, "can't be blank" )
        result = false
      end
    end
    result
  end
end
