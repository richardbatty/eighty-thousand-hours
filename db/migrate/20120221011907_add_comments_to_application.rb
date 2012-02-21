class AddCommentsToApplication < ActiveRecord::Migration
  def change
    add_column :members, :donation_percentage_comment, :string
    add_column :members, :donation_average_income_comment, :string
    add_column :members, :donation_hic_activity_hours_comment, :string
  end
end
