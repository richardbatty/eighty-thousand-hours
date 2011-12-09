class AddBooleanDefaultsToMember < ActiveRecord::Migration
  def change
    change_column :members, :doing_good_research,    :boolean, :default => false
    change_column :members, :doing_good_influencing, :boolean, :default => false
    change_column :members, :doing_good_prophil,     :boolean, :default => false
  end
end
