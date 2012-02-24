ActiveAdmin.register Member do
  menu :if => proc{ can?(:read, Member) }
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
    column "Confirmed?" do |member|
      member.confirmed ? "<span class='status ok'>YES</span>".html_safe : "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_member_path(member), :method => :put})".html_safe
    end
    column :created_at
    column "80k application" do |member|
      link_to "View 80k application", admin_eighty_thousand_hours_application_path(member.eighty_thousand_hours_application) unless member.eighty_thousand_hours_application.nil?
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
               :location,
               :phone,
               :public_profile,
               :confirmed,
               :on_team,
               :team_role,
               :avatar,
               :external_twitter,
               :external_facebook,
               :external_linkedin
      f.buttons
    end
  end
end
