class AddDefaultsToDoingGood < ActiveRecord::Migration
  def change
    change_column_default(:members, :doing_good_innovating, false)
    change_column_default(:members, :doing_good_improving, false)
  end
end
