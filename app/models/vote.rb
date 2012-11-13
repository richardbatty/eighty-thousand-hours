class Vote < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :discussion_post
  belongs_to :user

  scope :by_user, lambda{|u| where( :user_id => u )}
  scope :by_blog_post, lambda{|p| where( :blog_post_id => p )}
  scope :by_discussion_post, lambda{|p| where( :discussion_post_id => p )}

  scope :upvotes, where(:positive => true)
  scope :downvotes, where(:positive => false)

  scope :recent, order("created_at DESC").limit(3)
end
