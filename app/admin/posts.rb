ActiveAdmin.register Post do
  menu :if => proc{ can?(:manage, Post) }
  controller.authorize_resource
  
  scope :draft
  scope :published

  index do
    column :created_at
    column :title
    column :author
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
end
