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
  scope :popular, lambda{|n| where(:draft => false).order("facebook_likes DESC").limit(n)}


  # a Post can have votes from many different users
  has_many :votes

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
