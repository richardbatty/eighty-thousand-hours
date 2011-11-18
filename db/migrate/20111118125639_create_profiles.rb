class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :background
      t.string  :career_plans
      t.string  :location
      t.boolean :pledge

      t.references :user

      t.timestamps
    end
  end
end
