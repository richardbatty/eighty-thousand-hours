class AddFieldsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :name, :string
    add_column :comments, :email, :string
  end
end
