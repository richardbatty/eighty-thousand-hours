class RemoveReferencesToMember < ActiveRecord::Migration
  def change
    remove_column :donations, :member_id
    add_index :donations, :user_id

    remove_column :eighty_thousand_hours_applications, :member_id
    remove_column :eighty_thousand_hours_profiles, :member_id

    drop_table :members
  end
end
