class Post < ActiveRecord::Base
  scope :draft,     where(:draft => true).order("created_at DESC")
  scope :published, where(:draft => false).order("created_at DESC")
end
