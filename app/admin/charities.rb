ActiveAdmin.register Charity do
  menu :if => proc{ can?(:manage, Charity) }

  index do
    column :name
    column :created_at
    column :donations do |charity|
      charity.donations.size
    end
    default_actions
  end
end
