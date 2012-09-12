class AddMenuSidebarToPages < ActiveRecord::Migration
  def change
    add_column :pages, :menu_sidebar, :boolean, :default => false
  end
end
