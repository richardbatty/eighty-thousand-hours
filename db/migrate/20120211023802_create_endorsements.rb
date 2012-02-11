class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.string :author
      t.string :position
      t.text :body

      t.timestamps
    end
  end
end
