class RenamePostsToBlogPosts < ActiveRecord::Migration
  def change
    rename_table :posts, :blog_posts
  end
end
