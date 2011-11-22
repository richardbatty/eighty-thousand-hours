class ChangeStringsToTextsForMemberColumns < ActiveRecord::Migration
  def self.up
    change_table :members do |t|
      t.change :background, :text
      t.change :career_plans, :text
      t.change :inspiration, :text
      t.change :interesting_fact, :text
      t.change :organisation_role, :text
     end
  end

  def self.down
    change_table :members do |t|
      t.change :background, :string
      t.change :career_plans, :string
      t.change :inspiration, :string
      t.change :interesting_fact, :string
      t.change :organisation_role, :string
     end
  end
end
