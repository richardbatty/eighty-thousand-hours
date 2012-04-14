ActiveAdmin.register Comment, :as => "PostComment" do
  menu :if => proc{ can?(:manage, Comment) },
       :label => "Comments"
  controller.authorize_resource
end
