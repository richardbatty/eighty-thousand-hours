class ChangeAmountToIntegerInDonations < ActiveRecord::Migration
  def change
    change_column :donations, :amount, :integer, :default => 0
    rename_column :donations, :amount, :amount_cents
  end
end
