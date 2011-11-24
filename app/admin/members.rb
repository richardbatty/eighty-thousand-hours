ActiveAdmin.register Member do
  scope :confirmed
  # show do
  #   attributes_table do
  #     tbody do
  #       tr pretty_format member.id
  #       tr pretty_format member.user ? member.name : "NO USER"
  #       para pretty_format member.background
  #       para pretty_format member.career_plans
  #       para pretty_format member.inspiration
  #       para pretty_format member.interesting_fact
  #       para pretty_format member.location
  #       para pretty_format member.organisation_role
  #       para pretty_format member.show_name
  #       para pretty_format member.show_info
  #       para pretty_format member.confirmed
  #     end
  #   end
  # end
  
  # def name(member)
  #   member.user.nil? ? "NO USER" : member.name
  # end
  
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
    column "Show Name?", :show_name
    column "Show Info?", :show_info
    column "Confirmed?", :confirmed
    column "On team?",   :on_team
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
               :show_name,
               :show_info,
               :confirmed,
               :on_team,
               :team_role,
               :avatar
      f.buttons
    end
  end
end
