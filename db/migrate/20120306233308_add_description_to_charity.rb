class AddDescriptionToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :description, :text
  end
end
