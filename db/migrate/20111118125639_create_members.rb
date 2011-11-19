class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|

      # who are you, condensed life story
      t.string :background

      # future plans, justify how this best achieves aim of doing most good
      t.string :career_plans

      # what inspired you to become a member?
      t.string :inspiration

      # add some color e.g. "I once ran to Mongolia for SCI"
      t.string :interesting_fact

      # physical location e.g. Oxford, England
      t.string :location

      # your role in the organisation e.g. volunteer blogger
      t.string :organisation_role

      # can we list your name on the website?
      t.boolean :show_name, :default => true

      # should we display your info on the member page?
      t.boolean :show_info, :default => true

      # has this member been confirmed by an admin?
      #t.boolean :confirmed, :default => false

      # a Member belongs_to a User
      t.references :user

      t.timestamps

    end
  end
end
