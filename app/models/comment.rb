class Comment < ActiveRecord::Base
  validates_presence_of :body,    message: "can't be blank"
  validates_presence_of :post_id, message: "Comment must be on a specific post"
  validates_presence_of :user_id, message: "Comment must be by a specific user"

  def get_user_name
    user ? user.name : "DELETED"
  end

  before_destroy :check_for_children

  belongs_to :user
  belongs_to :post

  # nested comments with Ancestry gem
  has_ancestry

  private
  def check_for_children
    if has_children?
      # need to keep the comment as it has children in a thread
      self.user = nil
      self.body = nil

      # don't destroy this comment
      return false
    end
  end
end
