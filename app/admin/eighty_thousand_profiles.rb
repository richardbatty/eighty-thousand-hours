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

  csv do
    column :member_id
    column :created_at
    column :confirmed
    column :name
    column :inspiration
    column :occupation
    column :organisation
    column :background
    column :career_plans
    column :doing_good_inspiring
    column :doing_good_research
    column :doing_good_philanthropy
    column :doing_good_prophilanthropy
    column :doing_good_improving
  end
end
