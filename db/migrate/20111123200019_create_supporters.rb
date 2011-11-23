class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|
      t.string :name
      t.string :email
      t.boolean :dont_email_me
      t.boolean :anonymous

      t.timestamps
    end
  end
end
