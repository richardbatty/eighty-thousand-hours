ActiveAdmin.register Member do
  form do |f|
    f.inputs "Details" do
      f.inputs :user,
               :background,
               :career_plans,
               :inspiration,
               :interesting_fact,
               :location,
               :organisation_role,
               :show_name,
               :show_info,
               :confirmed,
               :avatar
      f.buttons
    end
  end
end
