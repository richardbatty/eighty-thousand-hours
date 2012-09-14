class DiscussionPost < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # for versioning with paper_trail
  has_paper_trail

  # Alias for <tt>acts_as_taggable_on :tags</tt>:
  acts_as_taggable

  scope :draft,     where(:draft => true).order("created_at DESC")
  scope :published, where(:draft => false).order("created_at DESC")

  validates_presence_of :title
  validates_presence_of :body

  def self.recent(n)
    DiscussionPost.last(n)
  end

  def self.by_author( author, page )
    user = User.find_by_name( author )
    query = DiscussionPost.published.where("user_id = ?", user.id ).order("created_at DESC")
    query.paginate(:page => page, :per_page => 10)
  end

  def self.author_list
    users = where(:draft => false).where("user_id IS NOT NULL").select('DISTINCT user_id').map{|p| p.user.name}
    users.sort
  end

  # comments on posts
  has_many :comments, :dependent => :destroy

  # a User wrote this post
  belongs_to :user

  attr_accessible :title, :body, :user_id, :draft, :tag_list, :created_at

  # override to_param to specify format of URL
  # now we can call post_path(@post) and get
  # "/discussion/8-today-show" returned for example
  def to_param
    "#{self.id}-#{self.friendly_id}"
  end
end
