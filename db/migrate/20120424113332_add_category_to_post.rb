class AddCategoryToPost < ActiveRecord::Migration
  def change
    add_column :posts, :category, :string, :default => "discussion"
  end
end
