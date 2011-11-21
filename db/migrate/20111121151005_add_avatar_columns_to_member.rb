class AddAvatarColumnsToMember < ActiveRecord::Migration
  def change
    add_column :members, :avatar_file_name,    :string
    add_column :members, :avatar_content_type, :string
    add_column :members, :avatar_file_size,    :integer
    add_column :members, :avatar_updated_at,   :datetime
  end
end
