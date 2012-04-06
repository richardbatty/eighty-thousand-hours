class RemoveConfirmedFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :confirmed
  end
end
