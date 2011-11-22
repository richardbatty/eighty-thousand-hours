class ChangeStringsToTextsForMemberColumns < ActiveRecord::Migration
  def up
    change_column :members, :background, :text
    change_column :members, :career_plans, :text
    change_column :members, :inspiration, :text
    change_column :members, :interesting_fact, :text
    change_column :members, :organisation_role, :text
  end

  def down
    change_column :members, :background, :string
    change_column :members, :career_plans, :string
    change_column :members, :inspiration, :string
    change_column :members, :interesting_fact, :string
    change_column :members, :organisation_role, :string
  end
end
