class AddFieldsToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :date, :date
    add_column :donations, :currency, :string, :default => 'GBP'
  end
end
