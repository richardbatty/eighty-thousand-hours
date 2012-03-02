class AddDisplayInFooterToPage < ActiveRecord::Migration
  def change
    add_column :pages, :menu_display_in_footer, :boolean, :default => true
  end
end
