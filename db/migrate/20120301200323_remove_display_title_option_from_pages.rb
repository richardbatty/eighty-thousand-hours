class RemoveDisplayTitleOptionFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :show_title
  end
end
