ActiveAdmin.register EightyThousandHoursApplication do
  menu :if => proc{ can?(:manage, EightyThousandHoursApplication) },
       :label => "80k Applications",
       :parent => "80k Members"
  controller.authorize_resource

  action_item :only => :show do
    if !eighty_thousand_hours_application.user.confirmed
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
      e.user.confirmed ? "<span class='status ok'>YES</span>".html_safe : "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_user_path(e.user), :method => :put})".html_safe
    end

    default_actions
  end
end
