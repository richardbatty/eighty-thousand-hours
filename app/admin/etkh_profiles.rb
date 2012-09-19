ActiveAdmin.register EtkhProfile do
  menu :if => proc{ can?(:manage, EtkhProfile) },
       :label => "80k Profiles",
       :parent => "Members"
  controller.authorize_resource

  index do
    column :id
    column :name do |p|
      p.user.name
    end
    column :background

    default_actions
  end

  show do |etkh_profile|
    attributes_table do
      row :name do |p|
        p.user.name
      end
      row :background

      row :profile_option_causes do |p|
        p.profile_option_causes.map{|c| c.title}.join(', ')
      end
      row :causes_comment

      row :profile_option_activities do |p|
        p.profile_option_activities.map{|c| c.title}.join(', ')
      end
      row :activities_comment

      row :skills_knowledge_share
      row :skills_knowledge_learn

      row :donation_percentage
      row :donation_percentage_optout
    end
  end
end
