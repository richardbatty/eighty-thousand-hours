class DeleteEtkhApplications < ActiveRecord::Migration
  def change
    drop_table :etkh_applications
  end
end
