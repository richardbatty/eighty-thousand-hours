class AddConfirmedToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :confirmed, :boolean, :default => false
  end
end
