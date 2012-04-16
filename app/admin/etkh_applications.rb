ActiveAdmin.register EtkhApplication do
  menu :if => proc{ can?(:manage, EtkhApplication) },
       :label => "80k Applications",
       :parent => "Members"
  controller.authorize_resource

  action_item :only => :show do
    if !etkh_application.user.eighty_thousand_hours_member?
      link_to "Confirm member", confirm_admin_user_path(etkh_application.user), :method => :put
    end
  end

  index do
    column :id
    column :user
    column :updated_at
    column :occupation
    column :career_plans

    column "Confirmed?" do |e|
      if e.user.eighty_thousand_hours_member?
        "<span class='status ok'>YES</span>".html_safe
      else
        if e.user.eighty_thousand_hours_applicant?
          "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_user_path(e.user), :method => :put})".html_safe
        end
      end

    end

    default_actions
  end

  show do |user|
    attributes_table do
      row :user
      row :updated_at
      row :occupation
      row :career_plans
      row :spoken_to_existing_member
      row :doing_good_inspiring
      row :doing_good_research
      row :doing_good_philanthropy
      row :doing_good_innovating
      row :doing_good_improving
      row :doing_good_prophilanthropy
      row :donation_percentage
      row :donation_percentage_comment
      row :average_income
      row :average_income_comment
      row :hic_activity_hours
      row :hic_activity_hours_comment
      row :causes_givewell
      row :causes_gwwc
      row :causes_international
      row :causes_xrisk
      row :causes_meta
      row :causes_domestic
      row :causes_animal
      row :causes_political
      row :causes_comment
    end
  end
end
