class RemoveProfileFieldsFromMember < ActiveRecord::Migration
  def change
    remove_column :members, :inspiration
    remove_column :members, :interesting_fact
    remove_column :members, :background
    remove_column :members, :career_plans
    remove_column :members, :occupation
    remove_column :members, :organisation_role
    remove_column :members, :organisation
    remove_column :members, :public_profile
    remove_column :members, :contacted_date
    remove_column :members, :contacted_by
    remove_column :members, :doing_good_inspiring
    remove_column :members, :doing_good_research
    remove_column :members, :doing_good_philanthropy
    remove_column :members, :doing_good_innovating
    remove_column :members, :doing_good_improving
    remove_column :members, :doing_good_prophilanthropy
    remove_column :members, :parallel_universe_donation_percentage
    remove_column :members, :parallel_universe_donation_average_income
    remove_column :members, :parallel_universe_donation_hic_activity_hours
    remove_column :members, :parallel_universe_occupation
  end
end
