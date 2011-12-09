class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      # should accept donations < £10^8
      t.decimal :amount, precision: 10, scale: 2
      t.references :charity
      t.references :member

      t.timestamps
    end
    add_index :donations, :charity_id
    add_index :donations, :member_id
  end
end
