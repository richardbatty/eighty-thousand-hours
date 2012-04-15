ActiveAdmin.register Comment, :as => "PostComment" do
  menu :if => proc{ can?(:manage, Post) },
       :label => "Comments",
       :parent => "Blog"
end
