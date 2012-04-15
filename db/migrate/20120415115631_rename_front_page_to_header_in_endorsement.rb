class RenameFrontPageToHeaderInEndorsement < ActiveRecord::Migration
  def change
    rename_column :endorsements, :front_page, :header
  end
end
