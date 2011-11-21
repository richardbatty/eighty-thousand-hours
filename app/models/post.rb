class Post < ActiveRecord::Base
  scope :draft,     where(:draft => true)
  scope :published, where(:draft => false)
end
