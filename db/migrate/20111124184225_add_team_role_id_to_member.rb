class AddTeamRoleIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :team_role_id, :integer
  end
end
