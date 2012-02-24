ActiveAdmin.register Endorsement do
  menu :if => proc{ can?(:manage, Endorsement) },
       :parent => "80k site content"
  controller.authorize_resource
end
