class ChangeDefaultOptOutDonationPledge < ActiveRecord::Migration
  def change
    change_column :etkh_profiles, :donation_percentage_optout, :boolean, :default => true
  end
end
