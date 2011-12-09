ActiveAdmin.register Member do
  menu :if => proc{ can?(:manage, Member) }     
  controller.authorize_resource
  
  scope :confirmed
  scope :unconfirmed
  
  index do
    column :id
    column :avatar do |member|
      image_tag member.avatar.url(:thumb)
    end
    column :name do |member|
      member.user ? member.name : "NO USER"
    end
    column "Confirmed?",      :confirmed
    column :created_at
    default_actions
  end
  
  member_action :confirm, :method => :put do
    member = Member.find(params[:id])
    member.confirmed = true
    member.save
    redirect_to admin_member_path(member), :notice => "Member confirmed!"
  end
  
  form do |f|
    f.inputs "Details" do
      f.inputs :user,
               :apply_occupation,
               :apply_reasons_for_joining,
               :apply_heard_about_us,
               :apply_spoken_to_existing_member,
               :apply_career_plans,
               :background,
               :occupation,
               :organisation,
               :career_plans,
               :inspiration,
               :location,
               :phone,
               :interesting_fact,
               :organisation_role,
               :public_profile,
               :confirmed,
               :on_team,
               :team_role,
               :avatar,
               :doing_good_influencing,
               :doing_good_research,
               :doing_good_prophil,
               :external_twitter,
               :external_facebook,
               :external_linkedin
      f.buttons
    end
  end
end
