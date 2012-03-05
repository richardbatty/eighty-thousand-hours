class ChangeMemberIdToUserId < ActiveRecord::Migration
  def change
    rename_column :donations,                          :member_id, :user_id
    rename_column :eighty_thousand_hours_applications, :member_id, :user_id
    rename_column :eighty_thousand_hours_profiles,     :member_id, :user_id
  end
end
