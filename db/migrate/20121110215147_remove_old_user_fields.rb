class RemoveOldUserFields < ActiveRecord::Migration
  def change
    drop_table :team_roles
    remove_column :users, :on_team
    remove_column :users, :team_role_id
  end
end
