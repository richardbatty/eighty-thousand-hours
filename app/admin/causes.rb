ActiveAdmin.register Cause do
  menu :if => proc{ can?(:manage, Cause) }

  index do
    column :name
    column :created_at
    column :donations do |cause|
      cause.donations.size
    end
    default_actions
  end
end
