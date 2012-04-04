class AddAttachedImagesModel < ActiveRecord::Migration
  def change
    create_table :attached_images do |t|
      t.references :post
      t.has_attached_file :image

      t.timestamps
    end
  end
end
