class AddHeaderTitleToPage < ActiveRecord::Migration
  def change
    add_column :pages, :header_title, :string
  end
end
