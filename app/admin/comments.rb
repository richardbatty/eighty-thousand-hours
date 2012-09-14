ActiveAdmin.register Comment, :as => "PostComment" do
  index do
    column :id
    column :name
    column :email
    column :user
    column :blog_post
    column :discussion_post
    column :body
    column :created_at
    default_actions
  end
end
