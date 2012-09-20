ActiveAdmin.register Comment, :as => "Blog/Discussion Comments" do
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
