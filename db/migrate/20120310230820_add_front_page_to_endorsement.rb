class AddFrontPageToEndorsement < ActiveRecord::Migration
  def change
    add_column :endorsements, :front_page, :boolean, :default => false
  end
end
