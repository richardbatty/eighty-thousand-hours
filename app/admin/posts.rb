ActiveAdmin.register Post do
  menu :if => proc{ can?(:manage, Post) },
       :label => "Blog"
  controller.authorize_resource
  
  scope :draft
  scope :published

  index do
    column :created_at
    column :title
    column :author
    column :draft do |p|
      p.draft? ? "<span class='status warn'>draft</span>".html_safe : ""
    end
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.inputs :title,
               :body,
               :teaser,
               :author,
               :attribution,
               :created_at,
               :draft,
               :tag_list
      f.buttons
    end
  end

  # for History sidebar in show view
  controller do
    def show
        @post = Post.find(params[:id])
        @versions = @post.versions 
        @post = @post.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versions, :partial => "admin/version_sidebar", :only => :show

  sidebar :view_on_site, :only => :show do
    @post = Post.find(params[:id])
    link_to "View live on site", post_path(@post)
  end
end
