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
      link_to "80k application", admin_eighty_thousand_hours_application_path(member.eighty_thousand_hours_application) unless member.eighty_thousand_hours_application.nil?
    end
    column "80k profile" do |member|
      link_to "80k profile", admin_eighty_thousand_hours_profile_path(member.eighty_thousand_hours_profile) unless member.eighty_thousand_hours_profile.nil?
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

  csv do
    column :id
    column :created_at
    column :confirmed
    column :name

    column ("Application: Occupation") { |member| member.eighty_thousand_hours_application[:occupation] }
    column ("Application: Career Plans") { |member| member.eighty_thousand_hours_application[:career_plans] }
    column ("Application: Spoken to existing member?") { |member| member.eighty_thousand_hours_application[:spoken_to_existing_member] }
    column ("Application: Donation percentage") { |member| member.eighty_thousand_hours_application[:donation_percentage] }
    column ("Application: Donation comment") { |member| member.eighty_thousand_hours_application[:donation_comment] }
    column ("Application: Average income") { |member| member.eighty_thousand_hours_application[:average_income] }
    column ("Application: Income comment") { |member| member.eighty_thousand_hours_application[:average_income_percentage] }
    column ("Application: HIC activity hours") { |member| member.eighty_thousand_hours_application[:hic_activity_hours] }
    column ("Application: HIC activity hours comment") { |member| member.eighty_thousand_hours_application[:hic_activity_hours_comment] }
    column ("Application: Donate to: GiveWell recommended") { |member| member.eighty_thousand_hours_application[:causes_givewell] }
    column ("Application: Donate to: GWWC recommended") { |member| member.eighty_thousand_hours_application[:causes_gwwc] }
    column ("Application: Donate to: Other international") { |member| member.eighty_thousand_hours_application[:causes_international] }
    column ("Application: Donate to: Other domestic") { |member| member.eighty_thousand_hours_application[:causes_domestic] }
    column ("Application: Donate to: X-risk") { |member| member.eighty_thousand_hours_application[:causes_xrisk] }
    column ("Application: Donate to: Meta") { |member| member.eighty_thousand_hours_application[:causes_meta] }
    column ("Application: Donate to: Animal charities") { |member| member.eighty_thousand_hours_application[:causes_animal] }
    column ("Application: Donate to: Political charities") { |member| member.eighty_thousand_hours_application[:causes_political] }
    column ("Application: Doing Good Inspiring?") { |member| member.eighty_thousand_hours_application[:doing_good_inspiring] }
    column ("Application: Doing Good Research?") { |member| member.eighty_thousand_hours_application[:doing_good_research] }
    column ("Application: Doing Good Philanthropy?") { |member| member.eighty_thousand_hours_application[:doing_good_philanthropy] }
    column ("Application: Doing Good ProPhilanthropy??") { |member| member.eighty_thousand_hours_application[:doing_good_prophilanthropy] }
    column ("Application: Doing Good Improving?") { |member| member.eighty_thousand_hours_application[:doing_good_improving] }

    column ("Profile: Inspiration") { |member| member.eighty_thousand_hours_profile[:inspiration] }
    column ("Profile: Occupation") { |member| member.eighty_thousand_hours_profile[:occupation] }
    column ("Profile: Organisation") { |member| member.eighty_thousand_hours_profile[:organisation] }
    column ("Profile: Background") { |member| member.eighty_thousand_hours_profile[:background] }
    column ("Profile: Career Plans") { |member| member.eighty_thousand_hours_profile[:career_plans] }
    column ("Profile: Doing Good Inspiring?") { |member| member.eighty_thousand_hours_profile[:doing_good_inspiring] }
    column ("Profile: Doing Good Research?") { |member| member.eighty_thousand_hours_profile[:doing_good_research] }
    column ("Profile: Doing Good Philanthropy?") { |member| member.eighty_thousand_hours_profile[:doing_good_philanthropy] }
    column ("Profile: Doing Good ProPhilanthropy??") { |member| member.eighty_thousand_hours_profile[:doing_good_prophilanthropy] }
    column ("Profile: Doing Good Improving?") { |member| member.eighty_thousand_hours_profile[:doing_good_improving] }
  end
end
