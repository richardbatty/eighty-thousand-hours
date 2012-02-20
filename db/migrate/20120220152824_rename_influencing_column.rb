class RenameInfluencingColumn < ActiveRecord::Migration
  def change
    rename_column :members, :doing_good_influencing, :doing_good_inspiring
  end
end
