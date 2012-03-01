class AddMenuFieldsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :menu_top_level, :boolean, :default => false
    add_column :pages, :menu_display, :boolean, :default => true
    add_column :pages, :menu_priority, :integer, :default => 0
    add_column :pages, :just_a_link, :boolean, :default => false
    add_column :pages, :parent_id, :integer
  end
end
