class DiscussionPost < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # votes are independent from posts so destroy associated votes here
  before_destroy { |post| Vote.destroy_all "blog_post_id = #{post.id}" }

  # for versioning with paper_trail
  has_paper_trail

  # Alias for <tt>acts_as_taggable_on :tags</tt>:
  acts_as_taggable

  # a DiscussionPost can have votes from many different users
  has_many :votes, :dependent => :destroy

  scope :draft,     where(:draft => true).order("created_at DESC")
  scope :published, where(:draft => false).order("created_at DESC")

  validates_presence_of :title
  validates_presence_of :body

  def self.by_votes( n = DiscussionPost.all.size )
    n = 1 if n < 1
    where(:draft => false).sort_by{|p| p.net_votes}.reverse.slice(0..(n-1))
  end

  def self.recent(n)
    DiscussionPost.first(n)
  end

  def self.by_author( author, page )
    user = User.find_by_name( author )
    query = DiscussionPost.published.where("user_id = ?", user.id ).order("created_at DESC")
    query.paginate(:page => page, :per_page => 10)
  end

  def self.by_author_drafts( user_id )
    user = User.find( user_id )
    query = DiscussionPost.draft.where("user_id = ?", user.id ).order("created_at DESC")
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

  def vote! (user, up )
    user_votes = Vote.by_post(self).by_user(user)

    # check if user has already voted for this post
    if user_votes.empty?
      vote = Vote.new( :user => user, :post => self, :positive => up )
      vote.save
    else
      vote = user_votes.first
      if (up && vote.positive) || (!up && !vote.positive)
        # user already upvoted, and clicked up again
        # so we destroy the vote
        # and vice versa
        vote.destroy
      else
        # we had an upvote, and user clicked Down
        # so we change the upvote to a downvote
        # or vice versa
        vote.positive = !vote.positive
        vote.save
      end
    end
  end

  def net_votes
    self.votes.upvotes.size - self.votes.downvotes.size
  end

  def popularity
    # magic scaling factors in here...
    karma_votes = 0.0
    self.votes.upvotes.each do |v|
      karma_votes += 1.0/(1+(DateTime.now - v.created_at.to_datetime).to_i)
    end
    karma_votes
  end
end
