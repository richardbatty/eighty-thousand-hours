class Post < ActiveRecord::Base
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
  validates_presence_of :teaser

  def self.by_votes( n = Post.all.size )
    n = 1 if n < 1
    where(:draft => false).sort_by{|p| p.net_votes}.reverse.slice(0..(n-1))
  end

  def self.by_popularity( n = Post.all.size )
    n = 1 if n < 1
    where(:draft => false).sort_by{|p| p.popularity}.reverse.slice(0..(n-1))
  end

  def self.by_author( author, page )
    # see if we have a user with this name
    user = User.find_by_name( author )
    if user
      query = Post.published.where("user_id = ?", user.id ).order("created_at DESC")
    else
      query = Post.published.where("author = ?", author ).order("created_at DESC")
    end

    query.paginate(:page => page, :per_page => 10)
  end

  def self.author_list
    authors = where(:draft => false).where("author IS NOT NULL").select('DISTINCT author').map{|p| p.author}
    users   = where("user_id IS NOT NULL").select('DISTINCT user_id').map{|p| p.user.name}

    #(authors + users).sort
    users.sort
  end

  # a Post can have votes from many different users
  has_many :votes

  # a User wrote this post
  belongs_to :user

  # override to_param to specify format of URL
  # now we can call post_path(@post) and get
  # "/blog/8-today-show" returned for example
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
    self.facebook_likes + self.votes.upvotes.size - self.votes.downvotes.size
  end

  def popularity
    fb_votes = 0.01 * self.facebook_likes
    karma_votes = 0.0
    self.votes.upvotes.each do |v|
      karma_votes += 1.0/(1+(DateTime.now - Vote.first.created_at.to_datetime).to_i)
    end

    fb_votes + karma_votes
  end

  # first bit of the article -- used as
  # opengraph description, and on index page
  def get_teaser
    return self.teaser if self.teaser?

    # if post doesn't have a defined teaser then we try
    # to create one by grabbing the first couple of sentences

    # note that this fails in a lot of edge cases
    # http://stackoverflow.com/questions/1714657/find-some-sentences
    # failure cases so far:
    #   * sentence ends with ?
    #   * sentence contains URL www.blah.com
    #   * markdown should be stripped out
    sentences = self.body.split(".")
    if sentences.size >= 2
      sentences[0] + ". " + sentences[1] + "..."
    else
      return self.body
    end
  end

  # this is called by Heroku scheduler on a regular basis
  def self.update_facebook_likes
    Post.all.each do |p|
      num_likes = get_facebook_likes p
      p.facebook_likes = num_likes
      p.save
    end
  end

  # for active admin dashboard
  def admin_permalink
    admin_post_path(self)
  end

  private

  def self.http_get(domain,path,params)
    path = unless params.empty?
      path + "?" + params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
    else
      path
    end
    request = Net::HTTP.get(domain, path)
  end

  def self.get_facebook_likes(post)
    params = {
      :query => 'SELECT like_count FROM link_stat WHERE url = "http://80000hours.org' + "/blog/#{post.id}-#{post.slug}"+ '"',
      :format => 'json'
    }

    http = http_get('api.facebook.com', '/method/fql.query', params)
    result = JSON.parse(http)[0]["like_count"]
  end
end
