class AddDonationFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :donation_percentage, :string
    add_column :members, :donation_average_income, :string
    add_column :members, :donation_hic_activity_hours, :string
    add_column :members, :parallel_universe_donation_percentage, :string
    add_column :members, :parallel_universe_donation_average_income, :string
    add_column :members, :parallel_universe_donation_hic_activity_hours, :string
  end
end
