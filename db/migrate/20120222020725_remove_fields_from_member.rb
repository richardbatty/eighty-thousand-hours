class RemoveFieldsFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :donation_percentage_comment
    remove_column :members, :donation_average_income_comment
    remove_column :members, :donation_hic_activity_hours_comment
    remove_column :members, :donation_causes_givewell
    remove_column :members, :donation_causes_gwwc
    remove_column :members, :donation_causes_xrisk
    remove_column :members, :donation_causes_meta
    remove_column :members, :donation_causes_animal
    remove_column :members, :donation_causes_political
    remove_column :members, :donation_causes_international
    remove_column :members, :donation_causes_domestic
    remove_column :members, :donation_causes_comment
    remove_column :members, :donation_percentage
    remove_column :members, :donation_average_income
    remove_column :members, :donation_hic_activity_hours
    remove_column :members, :apply_occupation
    remove_column :members, :apply_career_plans
    remove_column :members, :apply_reasons_for_joining
    remove_column :members, :apply_heard_about_us
    remove_column :members, :apply_spoken_to_existing_member
  end
end
