class AddContactedToMember < ActiveRecord::Migration
  def change
    add_column :members, :contacted_date, :datetime
    add_column :members, :contacted_by, :string
  end
end
