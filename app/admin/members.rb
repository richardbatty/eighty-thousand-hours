ActiveAdmin.register Member do
  menu :if => proc{ can?(:read, Member) }
  controller.authorize_resource
  
  scope :confirmed
  scope :unconfirmed
  scope :contacted
  scope :not_contacted

  index do
    column :id
    column :avatar do |member|
      image_tag member.avatar.url(:thumb)
    end
    column :name do |member|
      member.user ? member.name : "NO USER"
    end
    column "Confirmed?" do |member|
      member.confirmed ? "<span class='status ok'>YES</span>".html_safe : "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_member_path(member), :method => :put})".html_safe
    end
    column :created_at
    column "80k application" do |member|
      link_to "View 80k application", admin_eth_application_path(member.eth_application) unless member.eth_application.nil?
    end

    default_actions
  end
  
  # Available at /admin/members/:id/confirm and #confirm_admin_post_path(member)
  member_action :confirm, :method => :put do
    member = Member.find(params[:id])
    member.confirmed = true
    member.save
    redirect_to admin_member_path(member), :notice => "Member confirmed!"
  end
  member_action :revoke, :method => :put do
    member = Member.find(params[:id])
    member.confirmed = false
    member.save
    redirect_to admin_member_path(member), :alert => "Membership confirmation revoked!"
  end

  action_item :only => :show do
    if !member.confirmed
      link_to "Confirm member", confirm_admin_member_path(member), :method => :put
    end
  end
  action_item :only => :show do
    if member.confirmed
      link_to "Revoke member", revoke_admin_member_path(member), :method => :put
    end
  end
  
  form do |f|
    f.inputs "Details" do
      f.inputs :user,
               :real_name,
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
               :doing_good_inspiring,
               :doing_good_research,
               :doing_good_prophil,
               :doing_good_innovating,
               :doing_good_improving,
               :external_twitter,
               :external_facebook,
               :external_linkedin,
               :contacted_date,
               :contacted_by
      f.buttons
    end
  end
end
