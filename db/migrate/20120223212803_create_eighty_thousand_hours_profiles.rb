class CreateEightyThousandHoursProfiles < ActiveRecord::Migration
  def change
    create_table :eighty_thousand_hours_profiles do |t|
      t.references :member
      t.timestamps

      t.text     :inspiration
      t.text     :interesting_fact
      t.text     :background
      t.text     :career_plans
      t.text     :occupation
      t.text     :organisation_role
      t.string   :organisation

      t.boolean  :public_profile, :default => true

      t.datetime :contacted_date
      t.string   :contacted_by
      t.boolean  :confirmed,      :default => false

      t.boolean  :doing_good_inspiring,       :default => false
      t.boolean  :doing_good_research,        :default => false
      t.boolean  :doing_good_philanthropy,    :default => false
      t.boolean  :doing_good_innovating,      :default => false
      t.boolean  :doing_good_improving,       :default => false
      t.boolean  :doing_good_prophilanthropy, :default => false
    end
  end
end
