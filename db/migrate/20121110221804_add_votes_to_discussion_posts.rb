class AddVotesToDiscussionPosts < ActiveRecord::Migration
  def change
    add_column :votes, :discussion_post_id, :integer
  end
end
