class AddOnTeamToMember < ActiveRecord::Migration
  def change
    add_column :members, :on_team, :boolean, :default => false
  end
end
