class AddDiscussionPostIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :discussion_post_id, :integer
  end
end
