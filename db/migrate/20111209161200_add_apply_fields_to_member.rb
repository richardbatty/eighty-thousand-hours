class AddApplyFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :apply_occupation, :text
    add_column :members, :apply_career_plans, :text
    add_column :members, :apply_reasons_for_joining, :text
    add_column :members, :apply_heard_about_us, :text
    add_column :members, :apply_spoken_to_existing_member, :text
  end
end
