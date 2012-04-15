ActiveAdmin.register Endorsement do
  menu :if => proc{ can?(:manage, Endorsement) },
       :parent => "80k site content"
  controller.authorize_resource
  form do |f|
      f.inputs :author,
               :position,
               :body,
               :front_page,
               :endorsement_page,
               :weight
      f.buttons
  end
end
