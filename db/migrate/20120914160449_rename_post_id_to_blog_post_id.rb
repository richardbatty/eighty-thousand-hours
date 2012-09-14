class RenamePostIdToBlogPostId < ActiveRecord::Migration
  def change
    rename_column :attached_images, :post_id, :blog_post_id
    rename_column :comments, :post_id, :blog_post_id
    rename_column :votes, :post_id, :blog_post_id
  end
end
