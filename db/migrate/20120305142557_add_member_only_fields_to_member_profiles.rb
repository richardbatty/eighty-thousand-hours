class AddMemberOnlyFieldsToMemberProfiles < ActiveRecord::Migration
  def change
    add_column :eighty_thousand_hours_profiles, :skills_knowledge_share, :text
    add_column :eighty_thousand_hours_profiles, :skills_knowledge_learn, :text
  end
end
