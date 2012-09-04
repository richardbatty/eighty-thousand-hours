class AddDonationPledgeToProfile < ActiveRecord::Migration
  def change
    add_column :etkh_profiles, :donation_percentage, :integer, :default => "30"
    add_column :etkh_profiles, :donation_percentage_optout, :boolean, :default => false 
  end
end
