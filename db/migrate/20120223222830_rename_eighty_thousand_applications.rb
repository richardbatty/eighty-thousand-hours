class RenameEightyThousandApplications < ActiveRecord::Migration
  def change
    rename_table :eighty_thousand_applications, :eighty_thousand_hours_applications
  end
end
