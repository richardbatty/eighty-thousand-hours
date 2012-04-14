class Comment < ActiveRecord::Base
  validates_presence_of :body,    message: "can't be blank"
  validates_presence_of :post_id, message: "Comment must be on a specific post"
  validates_presence_of :user_id, message: "Comment must be by a specific user"

  belongs_to :user
  belongs_to :post
end
