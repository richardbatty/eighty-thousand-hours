class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  scope :by_user, lambda{|u| where( :user_id => u )}
  scope :by_post, lambda{|p| where( :post_id => p )}

  scope :upvotes, where(:positive => true)
  scope :downvotes, where(:positive => false)

  scope :recent, order("created_at DESC").limit(3)
end
