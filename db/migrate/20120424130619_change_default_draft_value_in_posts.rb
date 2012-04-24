class ChangeDefaultDraftValueInPosts < ActiveRecord::Migration
  def change
    change_column_default :posts, :draft, false
  end
end
