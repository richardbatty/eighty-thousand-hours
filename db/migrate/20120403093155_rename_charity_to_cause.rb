class RenameCharityToCause < ActiveRecord::Migration
  def change
    rename_table :charities, :causes
    rename_column :donations, :charity_id, :cause_id
  end
end
