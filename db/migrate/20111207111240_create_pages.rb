class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :author
      t.integer :date
      t.text :history

      t.timestamps
    end
  end
end
