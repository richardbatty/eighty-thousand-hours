class ChangeDefaultDraftPost < ActiveRecord::Migration
  def change
    change_column :posts, :draft, :boolean, :default => true
  end
end
