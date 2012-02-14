ActiveAdmin.register Endorsement do
  menu :if => proc{ can?(:manage, Endorsement) }
  controller.authorize_resource
end
