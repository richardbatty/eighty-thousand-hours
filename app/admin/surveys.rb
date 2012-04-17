ActiveAdmin.register Survey do
  menu :if => proc{ can?(:manage, Survey) },
       :label => "Surveys"
  controller.authorize_resource
end
