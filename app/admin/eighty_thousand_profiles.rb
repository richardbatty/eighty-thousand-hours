ActiveAdmin.register EightyThousandHoursProfile do
  menu :if => proc{ can?(:manage, EightyThousandHoursProfile) },
       :label => "80k Profiles",
       :parent => "Members"
  controller.authorize_resource

  index do
    column :id
    column :name do |p|
      p.member.name
    end
    column :occupation
    column :career_plans

    default_actions
  end
end
