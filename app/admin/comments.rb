ActiveAdmin.register Comment do
  menu :if => proc{ can?(:manage, Comment) },
       :label => "Comments"
  controller.authorize_resource
end
