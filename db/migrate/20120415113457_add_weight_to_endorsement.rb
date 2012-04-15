class AddWeightToEndorsement < ActiveRecord::Migration
  def change
    add_column :endorsements, :weight, :integer, :default => 1
  end
end
