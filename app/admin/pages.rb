ActiveAdmin.register Page do
  menu :if => proc{ can?(:manage, Page) }
  controller.authorize_resource
  
  index do
    column :created_at
    column :title
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.inputs :title,
               :header_title,
               :body
      f.buttons
    end
  end

  # for History sidebar in show view
  controller do
    def show
        @page = Page.find(params[:id])
        @versions = @page.versions 
        @page = @page.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versions, :partial => "admin/version_sidebar", :only => :show
end
