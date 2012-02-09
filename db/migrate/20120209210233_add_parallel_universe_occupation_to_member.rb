class AddParallelUniverseOccupationToMember < ActiveRecord::Migration
  def change
    add_column :members, :parallel_universe_occupation, :string
  end
end
