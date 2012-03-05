class AddUniqueEmailToSupporters < ActiveRecord::Migration
  def change
    add_index :supporters, :email, :unique => true
  end
end
