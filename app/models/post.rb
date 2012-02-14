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
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # Alias for <tt>acts_as_taggable_on :tags</tt>:
  acts_as_taggable

  scope :draft,     where(:draft => true).order("created_at DESC")
  scope :published, where(:draft => false).order("created_at DESC")

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
    sentences[0] + ". " + sentences[1] + "..."
  end
end
