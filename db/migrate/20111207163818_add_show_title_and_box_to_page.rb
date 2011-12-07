class AddShowTitleAndBoxToPage < ActiveRecord::Migration
  def change
    add_column :pages, :show_title, :boolean, :default => true
    add_column :pages, :show_box,   :boolean, :default => true
  end
end
