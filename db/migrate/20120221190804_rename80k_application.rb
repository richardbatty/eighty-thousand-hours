class Rename80kApplication < ActiveRecord::Migration
  def change
    rename_table :eth_applications, :apply_to_80k_forms
  end
end
