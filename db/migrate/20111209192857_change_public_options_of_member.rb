class ChangePublicOptionsOfMember < ActiveRecord::Migration
  def change
    remove_column :members, :show_name
    remove_column :members, :show_info
    add_column    :members, :public_profile, :boolean, :default => true
  end
end
