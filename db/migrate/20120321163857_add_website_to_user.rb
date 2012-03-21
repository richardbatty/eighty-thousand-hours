class AddWebsiteToUser < ActiveRecord::Migration
  def change
    add_column :users, :external_website, :string
  end
end
