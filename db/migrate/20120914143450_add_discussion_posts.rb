class AddDiscussionPosts < ActiveRecord::Migration
  def change
    create_table :discussion_posts do |t|
      t.string :title
      t.text :body
      t.boolean :draft, :default => false
      t.integer  "user_id"
      t.string   "slug"
      t.timestamps
    end

    add_index :discussion_posts, :slug, :unique => true
  end
end
