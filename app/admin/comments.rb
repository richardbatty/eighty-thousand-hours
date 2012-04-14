ActiveAdmin.register Comment, :as => "PostComment" do
  #menu :if => proc{ can?(:manage, Post) }
  #controller.authorize_resource
end
