class RemoveReasonsForJoiningColumn < ActiveRecord::Migration
  def change
    remove_column :eighty_thousand_hours_applications, :reasons_for_joining   
  end
end
