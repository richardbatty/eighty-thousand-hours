ActiveAdmin.register Comment, :as => "PostComment" do
  menu :if => proc{ can?(:manage, Post) },
       :label => "Comments",
       :parent => "Blog"

  index do
    column :id
    column :name
    column :email
    column :user
    column :post
    column :body
    column :created_at
    default_actions
  end
end
