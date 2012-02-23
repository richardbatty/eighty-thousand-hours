class RenameFieldsInApplication < ActiveRecord::Migration
  def change
    rename_column :eighty_thousand_applications, :doing_good_prophil, :doing_good_philanthropy
    add_column :eighty_thousand_applications, :doing_good_prophilanthropy, :boolean

    rename_column :members, :doing_good_prophil, :doing_good_philanthropy
    add_column :members, :doing_good_prophilanthropy, :boolean, :default => false
  end
end
