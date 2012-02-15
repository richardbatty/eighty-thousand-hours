class AddFacebookLikesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :facebook_likes, :integer
  end
end
