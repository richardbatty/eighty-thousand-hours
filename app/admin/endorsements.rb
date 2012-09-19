ActiveAdmin.register Endorsement do
  menu :if => proc{ can?(:manage, Endorsement) }
  controller.authorize_resource
  form do |f|
      f.inputs :author,
               :position,
               :body,
               :header,
               :endorsement_page,
               :weight
      f.buttons
  end
end
