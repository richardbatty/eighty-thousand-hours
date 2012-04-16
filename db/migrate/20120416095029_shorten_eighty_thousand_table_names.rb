class ShortenEightyThousandTableNames < ActiveRecord::Migration
  def change
    rename_table :eighty_thousand_hours_profiles, :etkh_profiles
    rename_table :eighty_thousand_hours_applications, :etkh_applications
  end
end
