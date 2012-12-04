ActiveAdmin.register EtkhProfile do
  menu :if => proc{ can?(:manage, EtkhProfile) },
       :label => "80k Profiles",
       :parent => "Users"
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

  csv do
    # These first few fields refer to the User that owns this EtkhProfile
    column ("Id") {|profile| profile.user.id}
    column ("Name")     { |profile| profile.user.name }
    column ("Real name"){ |profile| profile.user.real_name }
    column ("Email")    { |profile| profile.user.email }
    column ("Location") { |profile| profile.user.location }

    # The remaining fields are in the EtkhProfile model
    column :background
    column :organisation
    column :public_profile
    column :skills_knowledge_share
    column :skills_knowledge_learn
    column :causes_comment
    column :activities_comment
    column :donation_percentage
    column :donation_percentage_optout

    # The causes/activities need special treatment as they live
    # in a separate database table, and we loop over each possible
    # cause, printing out ones that this EtkhProfile has selected
    column :profile_option_causes do |p|
      p.profile_option_causes.map{|c| c.title}.join(', ')
    end
    column :causes_comment

    column :profile_option_activities do |p|
      p.profile_option_activities.map{|c| c.title}.join(', ')
    end
    column :activities_comment
  end
end
