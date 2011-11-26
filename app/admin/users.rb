ActiveAdmin.register User do
  menu :if => proc{ can?(:manage, User) }
  controller.authorize_resource
end
