ActiveAdmin.register User do
  menu :if => proc{ can?(:manage, User) }
  controller.authorize_resource

  index do
    column :id
    column :name
    column :slug
    column :last_sign_in_at
  end
end
