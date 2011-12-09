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
    column :location
    column :organisation_role
    column "Public profile?", :public_profile
    column "Confirmed?",      :confirmed
    column "On team?",        :on_team
    column "Team role",       :team_role
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
               :background,
               :career_plans,
               :inspiration,
               :interesting_fact,
               :location,
               :organisation_role,
               :public_profile,
               :confirmed,
               :on_team,
               :team_role,
               :avatar
      f.buttons
    end
  end
end
