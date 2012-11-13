ActiveAdmin.register Role do
  menu :if => proc{ can?(:manage, Role) }
  controller.authorize_resource

  form do |f|
    f.inputs "Details" do
      f.input :users, :collection => User.order("name ASC"), :as => :check_boxes 
      f.buttons
    end
  end
end
