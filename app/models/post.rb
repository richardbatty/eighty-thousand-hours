# == Schema Information
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  body        :text
#  draft       :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  attribution :string(255)
#  slug        :string(255)
#  teaser      :text
#  author      :string(255)
#

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
  scope :popular, lambda{|n| order("facebook_likes DESC").limit(n)}

  # override to_param to specify format of URL
  # now we can call post_path(@post) and get
  # "/blog/8-today-show" returned for example
  def to_param
    "#{self.id}-#{self.friendly_id}"
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
