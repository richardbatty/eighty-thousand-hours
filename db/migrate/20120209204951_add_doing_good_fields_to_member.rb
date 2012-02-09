class AddDoingGoodFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :doing_good_innovating, :boolean
    add_column :members, :doing_good_improving, :boolean
  end
end
