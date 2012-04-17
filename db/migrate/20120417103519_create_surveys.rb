class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.string :slug

      t.string :url

      t.string :name_box
      t.string :email_box
      t.string :id_box

      t.timestamps
    end
    add_index :surveys, :slug, :unique => true
  end
end
