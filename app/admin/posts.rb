ActiveAdmin.register Post do
  scope :draft
  scope :published
  
  form do |f|
    f.inputs "Details" do
      f.inputs :title,
               :body,
               :author,
               :created_at,
               :draft
      f.buttons
    end
  end
  
end
