class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  scope :draft,     where(:draft => true).order("created_at DESC")
  scope :published, where(:draft => false).order("created_at DESC")

  # override to_param to specify format of URL
  # now we can call post_path(@post) and get
  # "/blog/8-today-show" returned for example
  def to_param
    "#{self.id}-#{self.friendly_id}"
  end
end
