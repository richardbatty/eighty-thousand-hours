class ChangeApplicationFormDatatypes < ActiveRecord::Migration
  def change
    change_column :eighty_thousand_hours_applications, :donation_percentage_comment, :text
    change_column :eighty_thousand_hours_applications, :average_income_comment, :text
    change_column :eighty_thousand_hours_applications, :hic_activity_hours_comment, :text
    change_column :eighty_thousand_hours_applications, :causes_comment, :text
  end
end
