class AddRealNameToMember < ActiveRecord::Migration
  def change
    add_column :members, :real_name, :string
  end
end
