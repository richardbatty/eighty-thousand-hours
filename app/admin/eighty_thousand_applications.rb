ActiveAdmin.register EightyThousandHoursApplication do
  menu :if => proc{ can?(:manage, EightyThousandHoursApplication) },
       :label => "80k Applications",
       :parent => "Members"
  controller.authorize_resource

  action_item :only => :show do
    if !eighty_thousand_hours_application.user.eighty_thousand_hours_member?
      link_to "Confirm member", confirm_admin_user_path(eighty_thousand_hours_application.user), :method => :put
    end
  end

  index do
    column :id
    column :name do |e|
      e.user.name
    end
    column :occupation
    column :career_plans
    column :reasons_for_joining

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
end
