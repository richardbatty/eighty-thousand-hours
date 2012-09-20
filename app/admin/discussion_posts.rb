ActiveAdmin.register DiscussionPost do
  menu :if => proc{ can?(:manage, DiscussionPost) }
  controller.authorize_resource
  
  scope :draft
  scope :published

  index do
    column :created_at
    column :title
    column :user
    column :draft do |p|
      p.draft? ? "<span class='status warn'>draft</span>".html_safe : ""
    end
    default_actions
  end

  show do |post|
    attributes_table do
      row :title
      row :user
      row :created_at
      row :draft do
        post.draft? ? "<span class='status warn'>draft</span>".html_safe : "false"
      end
      row :body do
        markdown post.body
      end
    end
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :body
      f.input :user, :collection => User.order("name ASC")
      f.input :created_at
      f.input :draft
    end
    f.buttons
  end

  sidebar :view_on_site, :only => :show do
    @post = DiscussionPost.find(params[:id])
    link_to "View live on site", discussion_post_path(@post)
  end
end
