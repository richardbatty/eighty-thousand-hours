class AddNewProfileFieldsToMember < ActiveRecord::Migration
  def change
    add_column :members, :organisation, :string
    add_column :members, :occupation, :text
    add_column :members, :doing_good_influencing, :boolean
    add_column :members, :doing_good_research, :boolean
    add_column :members, :doing_good_prophil, :boolean
    add_column :members, :external_twitter, :string
    add_column :members, :external_facebook, :string
    add_column :members, :external_linkedin, :string
  end
end
