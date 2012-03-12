class AddEndorsementPageToEndorsement < ActiveRecord::Migration
  def change
    add_column :endorsements, :endorsement_page, :boolean, :default => true
  end
end
