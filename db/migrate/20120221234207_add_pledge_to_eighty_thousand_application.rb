class AddPledgeToEightyThousandApplication < ActiveRecord::Migration
  def change
    add_column :eighty_thousand_applications, :pledge, :boolean, :default => false
  end
end
