ActiveAdmin.register User do
  menu :if => proc{ can?(:manage, User) },
       :label => "Members"
  controller.authorize_resource

  filter :name
  filter :email
  filter :location

  #scope :confirmed
  #scope :unconfirmed

  index do
    column :id
    column :avatar do |user|
      image_tag user.avatar.url(:thumb), :style => "height: 50px"
    end
    column :name
    column :slug
    column :last_sign_in_at
    column :confirmed
    column "Confirmed?" do |user|
      user.eighty_thousand_hours_member? ? "<span class='status ok'>YES</span>".html_safe : "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_user_path(user), :method => :put})".html_safe
    end
    column :created_at
    column "80k application" do |user|
      link_to "80k application", admin_eighty_thousand_hours_application_path(user.eighty_thousand_hours_application) unless user.eighty_thousand_hours_application.nil?
    end
    column "80k profile" do |user|
      link_to "80k profile", admin_eighty_thousand_hours_profile_path(user.eighty_thousand_hours_profile) unless user.eighty_thousand_hours_profile.nil?
    end

    default_actions
  end

  # Available at /admin/users/:id/confirm and #confirm_admin_post_path(user)
  member_action :confirm, :method => :put do
    user = User.find(params[:id])
    user.eighty_thousand_hours_profile = EightyThousandHoursProfile.new
    user.save
    redirect_to admin_user_path(user), :notice => "User confirmed!"
  end
  member_action :revoke, :method => :put do
    user = User.find(params[:id])
    user.eighty_thousand_hours_profile.destroy
    user.save
    redirect_to admin_user_path(user), :alert => "Membership confirmation revoked!"
  end

  action_item :only => :show do
    if !user.confirmed
      link_to "Confirm member", confirm_admin_user_path(user), :method => :put
    end
  end
  action_item :only => :show do
    if user.confirmed
      link_to "Revoke member", revoke_admin_user_path(user), :method => :put
    end
  end

  form do |f|
    f.inputs "Details" do
      f.inputs :name,
               :email,
               :password,
               :password_confirmation,
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

    column ("Application: Occupation") { |user| user.eighty_thousand_hours_application[:occupation] }
    column ("Application: Career Plans") { |user| user.eighty_thousand_hours_application[:career_plans] }
    column ("Application: Spoken to existing user?") { |user| user.eighty_thousand_hours_application[:spoken_to_existing_member] }
    column ("Application: Donation percentage") { |user| user.eighty_thousand_hours_application[:donation_percentage] }
    column ("Application: Donation comment") { |user| user.eighty_thousand_hours_application[:donation_comment] }
    column ("Application: Average income") { |user| user.eighty_thousand_hours_application[:average_income] }
    column ("Application: Income comment") { |user| user.eighty_thousand_hours_application[:average_income_percentage] }
    column ("Application: HIC activity hours") { |user| user.eighty_thousand_hours_application[:hic_activity_hours] }
    column ("Application: HIC activity hours comment") { |user| user.eighty_thousand_hours_application[:hic_activity_hours_comment] }
    column ("Application: Donate to: GiveWell recommended") { |user| user.eighty_thousand_hours_application[:causes_givewell] }
    column ("Application: Donate to: GWWC recommended") { |user| user.eighty_thousand_hours_application[:causes_gwwc] }
    column ("Application: Donate to: Other international") { |user| user.eighty_thousand_hours_application[:causes_international] }
    column ("Application: Donate to: Other domestic") { |user| user.eighty_thousand_hours_application[:causes_domestic] }
    column ("Application: Donate to: X-risk") { |user| user.eighty_thousand_hours_application[:causes_xrisk] }
    column ("Application: Donate to: Meta") { |user| user.eighty_thousand_hours_application[:causes_meta] }
    column ("Application: Donate to: Animal causes") { |user| user.eighty_thousand_hours_application[:causes_animal] }
    column ("Application: Donate to: Political causes") { |user| user.eighty_thousand_hours_application[:causes_political] }
    column ("Application: Doing Good Inspiring?") { |user| user.eighty_thousand_hours_application[:doing_good_inspiring] }
    column ("Application: Doing Good Research?") { |user| user.eighty_thousand_hours_application[:doing_good_research] }
    column ("Application: Doing Good Philanthropy?") { |user| user.eighty_thousand_hours_application[:doing_good_philanthropy] }
    column ("Application: Doing Good ProPhilanthropy??") { |user| user.eighty_thousand_hours_application[:doing_good_prophilanthropy] }
    column ("Application: Doing Good Improving?") { |user| user.eighty_thousand_hours_application[:doing_good_improving] }

    column ("Profile: Inspiration") { |user| user.eighty_thousand_hours_profile[:inspiration] }
    column ("Profile: Occupation") { |user| user.eighty_thousand_hours_profile[:occupation] }
    column ("Profile: Organisation") { |user| user.eighty_thousand_hours_profile[:organisation] }
    column ("Profile: Background") { |user| user.eighty_thousand_hours_profile[:background] }
    column ("Profile: Career Plans") { |user| user.eighty_thousand_hours_profile[:career_plans] }
    column ("Profile: Doing Good Inspiring?") { |user| user.eighty_thousand_hours_profile[:doing_good_inspiring] }
    column ("Profile: Doing Good Research?") { |user| user.eighty_thousand_hours_profile[:doing_good_research] }
    column ("Profile: Doing Good Philanthropy?") { |user| user.eighty_thousand_hours_profile[:doing_good_philanthropy] }
    column ("Profile: Doing Good ProPhilanthropy??") { |user| user.eighty_thousand_hours_profile[:doing_good_prophilanthropy] }
    column ("Profile: Doing Good Improving?") { |user| user.eighty_thousand_hours_profile[:doing_good_improving] }
  end
end
