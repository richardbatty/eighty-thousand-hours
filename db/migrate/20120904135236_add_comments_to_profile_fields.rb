class AddCommentsToProfileFields < ActiveRecord::Migration
  def change
    add_column :etkh_profiles, :causes_comment, :text
    add_column :etkh_profiles, :activities_comment, :text
  end
end
