ActiveAdmin.register EightyThousandHoursApplication do
  menu :if => proc{ can?(:manage, EightyThousandHoursApplication) },
       :label => "80k Applications",
       :parent => "Members"
  controller.authorize_resource

  action_item :only => :show do
    if !eighty_thousand_hours_application.member.confirmed
      link_to "Confirm member", confirm_admin_member_path(eighty_thousand_hours_application.member), :method => :put
    end
  end

  index do
    column :id
    column :name do |e|
      e.member.name
    end
    column :occupation
    column :career_plans
    column :reasons_for_joining

    column "Confirmed?" do |e|
      e.member.confirmed ? "<span class='status ok'>YES</span>".html_safe : "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_member_path(e.member), :method => :put})".html_safe
    end

    default_actions
  end
end
