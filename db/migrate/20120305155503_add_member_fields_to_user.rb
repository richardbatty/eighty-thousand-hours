class AddMemberFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :confirmed, :boolean, :default => false
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime
    add_column :users, :phone, :string
    add_column :users, :on_team, :boolean, :default => false
    add_column :users, :team_role_id, :integer 
    add_column :users, :external_twitter, :string
    add_column :users, :external_facebook, :string
    add_column :users, :external_linkedin, :string
    add_column :users, :real_name, :string
  end
end
