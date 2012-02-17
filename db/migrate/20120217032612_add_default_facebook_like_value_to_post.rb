class AddDefaultFacebookLikeValueToPost < ActiveRecord::Migration
  def change
    change_column_default(:posts, :facebook_likes, 0)
  end
end
