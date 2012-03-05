class AddUserIdToModels < ActiveRecord::Migration
  def change
    add_column :donations,                          :user_id, :integer
    add_column :eighty_thousand_hours_applications, :user_id, :integer
    add_column :eighty_thousand_hours_profiles,     :user_id, :integer
  end
end
