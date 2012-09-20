class RemoveMoreOldProfileFields < ActiveRecord::Migration
  def change
    remove_column :etkh_profiles, :career_plans
    remove_column :etkh_profiles, :occupation
    remove_column :etkh_profiles, :organisation_role
    remove_column :etkh_profiles, :contacted_date
    remove_column :etkh_profiles, :contacted_by
    remove_column :etkh_profiles, :confirmed
    remove_column :etkh_profiles, :interesting_fact
    remove_column :etkh_profiles, :inspiration
  end
end
