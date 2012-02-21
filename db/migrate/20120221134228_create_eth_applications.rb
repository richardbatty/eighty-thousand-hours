class CreateEthApplications < ActiveRecord::Migration
  def change
    create_table :eth_applications do |t|
      t.references :member
      t.timestamps

      t.text :occupation
      t.text :career_plans
      t.text :reasons_for_joining
      t.text :spoken_to_existing_member

      t.boolean :doing_good_inspiring
      t.boolean :doing_good_research
      t.boolean :doing_good_prophil
      t.boolean :doing_good_innovating
      t.boolean :doing_good_improving

      t.string :donation_percentage
      t.string :donation_percentage_comment

      t.string :average_income
      t.string :average_income_comment

      t.string :hic_activity_hours
      t.string :hic_activity_hours_comment

      t.boolean :causes_givewell
      t.boolean :causes_gwwc
      t.boolean :causes_international
      t.boolean :causes_xrisk
      t.boolean :causes_meta
      t.boolean :causes_domestic
      t.boolean :causes_animal
      t.boolean :causes_political
      t.string  :causes_comment
    end
  end
end
