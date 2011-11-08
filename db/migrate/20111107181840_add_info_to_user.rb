class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :bio, :text
    add_column :users, :pledge, :boolean
    add_column :users, :public, :boolean
  end
end
