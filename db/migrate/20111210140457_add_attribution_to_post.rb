class AddAttributionToPost < ActiveRecord::Migration
  def change
    rename_column :posts, :author, :attribution
    add_column    :posts, :author, :string
  end
end
