class RemoveOldProfileFields < ActiveRecord::Migration
  def change
    remove_column :etkh_profiles, :doing_good_inspiring
    remove_column :etkh_profiles, :doing_good_research
    remove_column :etkh_profiles, :doing_good_philanthropy
    remove_column :etkh_profiles, :doing_good_innovating
    remove_column :etkh_profiles, :doing_good_improving
    remove_column :etkh_profiles, :doing_good_prophilanthropy
  end
end
