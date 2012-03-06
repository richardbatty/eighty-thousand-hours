class AddSlugToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :slug, :string
    add_index  :charities, :slug, :unique => true
  end
end
