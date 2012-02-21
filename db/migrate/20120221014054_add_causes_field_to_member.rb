class AddCausesFieldToMember < ActiveRecord::Migration
  def change
    add_column :members, :donation_causes_givewell, :boolean
    add_column :members, :donation_causes_gwwc, :boolean
    add_column :members, :donation_causes_xrisk, :boolean
    add_column :members, :donation_causes_meta, :boolean
    add_column :members, :donation_causes_animal, :boolean
    add_column :members, :donation_causes_political, :boolean
    add_column :members, :donation_causes_international, :boolean
    add_column :members, :donation_causes_domestic, :boolean
    add_column :members, :donation_causes_comment, :string
  end
end
