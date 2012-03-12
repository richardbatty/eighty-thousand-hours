class AddPrivacyToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :public, :boolean, :default => true
    add_column :donations, :public_amount, :boolean, :default => false
  end
end
