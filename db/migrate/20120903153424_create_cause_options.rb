class CreateCauseOptions < ActiveRecord::Migration
  def change
    create_table :profile_option_causes do |t|
      t.string :title
    end

    create_table :profile_option_activities do |t|
      t.string :title
    end

    create_table :etkh_profiles_profile_option_causes, :id => false do |t|
      t.references :etkh_profile
      t.references :profile_option_cause
    end
    
    create_table :etkh_profiles_profile_option_activities, :id => false do |t|
      t.references :etkh_profile
      t.references :profile_option_activity
    end
  end
end
