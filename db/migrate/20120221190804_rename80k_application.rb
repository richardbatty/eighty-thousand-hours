class Rename80kApplication < ActiveRecord::Migration
  def change
    rename_table :eth_applications, :eighty_thousand_applications
  end
end
