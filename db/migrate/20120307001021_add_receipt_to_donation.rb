class AddReceiptToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :receipt_file_name,    :string
    add_column :donations, :receipt_content_type, :string
    add_column :donations, :receipt_file_size,    :integer
    add_column :donations, :receipt_updated_at,   :datetime
  end
end
