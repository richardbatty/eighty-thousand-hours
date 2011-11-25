class CreateTeamRoles < ActiveRecord::Migration
  def change
    create_table :team_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
