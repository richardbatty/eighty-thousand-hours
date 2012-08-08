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
    column :email
    column :omniauth_signup
    column :slug
    column :last_sign_in_at
    column "Confirmed?" do |user|
      if user.eighty_thousand_hours_member?
        "<span class='status ok'>YES</span>".html_safe
      else
        if user.eighty_thousand_hours_applicant?
          "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_user_path(user), :method => :put})".html_safe
        end
      end
    end
    column :created_at
    column "80k application" do |user|
      link_to "80k application", admin_etkh_application_path(user.etkh_application) unless user.etkh_application.nil?
    end
    column "80k profile" do |user|
      link_to "80k profile", admin_etkh_profile_path(user.etkh_profile) unless user.etkh_profile.nil?
    end

    default_actions
  end

  # Available at /admin/users/:id/confirm and #confirm_admin_post_path(user)
  member_action :confirm, :method => :put do
    user = User.find(params[:id])
    user.etkh_profile = EtkhProfile.new
    user.save
    redirect_to admin_user_path(user), :notice => "User confirmed!"
  end
  member_action :revoke, :method => :put do
    user = User.find(params[:id])
    user.etkh_profile.destroy
    user.save
    redirect_to admin_user_path(user), :alert => "Membership confirmation revoked!"
  end

  action_item :only => :show do
    if !user.eighty_thousand_hours_member?
      link_to "Confirm member", confirm_admin_user_path(user), :method => :put
    end
  end
  action_item :only => :show do
    if user.eighty_thousand_hours_member?
      link_to "Revoke member", revoke_admin_user_path(user), :method => :put
    end
  end

  show do |user|
    attributes_table do
      row :name
      row :email
      row :omniauth_signup
      row :real_name
      row :slug
      row :location
      row :etkh_profile
      row :etkh_application
      row :sign_in_count
      row :last_sign_in_at
      row :updated_at
      row :phone
      row :external_twitter
      row :external_linkedin
      row :external_facebook
      row :external_website
    end
  end

  form do |f|
    f.inputs "Details" do
      f.inputs :name,
               :omniauth_signup,
               :email,
               :password,
               :password_confirmation,
               :real_name,
               :location,
               :phone,
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
    column :name
    column :email

    column ("Application: Occupation")                      { |user| user.etkh_application.nil? ? nil : user.etkh_application[:occupation] }
    column ("Application: Career Plans")                    { |user| user.etkh_application.nil? ? nil : user.etkh_application[:career_plans] }
    column ("Application: Spoken to existing user?")        { |user| user.etkh_application.nil? ? nil : user.etkh_application[:spoken_to_existing_member] }
    column ("Application: Donation percentage")             { |user| user.etkh_application.nil? ? nil : user.etkh_application[:donation_percentage] }
    column ("Application: Donation comment")                { |user| user.etkh_application.nil? ? nil : user.etkh_application[:donation_comment] }
    column ("Application: Average income")                  { |user| user.etkh_application.nil? ? nil : user.etkh_application[:average_income] }
    column ("Application: Income comment")                  { |user| user.etkh_application.nil? ? nil : user.etkh_application[:average_income_percentage] }
    column ("Application: HIC activity hours")              { |user| user.etkh_application.nil? ? nil : user.etkh_application[:hic_activity_hours] }
    column ("Application: HIC activity hours comment")      { |user| user.etkh_application.nil? ? nil : user.etkh_application[:hic_activity_hours_comment] }
    column ("Application: Donate to: GiveWell recommended") { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_givewell] }
    column ("Application: Donate to: GWWC recommended")     { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_gwwc] }
    column ("Application: Donate to: Other international")  { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_international] }
    column ("Application: Donate to: Other domestic")       { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_domestic] }
    column ("Application: Donate to: X-risk")               { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_xrisk] }
    column ("Application: Donate to: Meta")                 { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_meta] }
    column ("Application: Donate to: Animal causes")        { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_animal] }
    column ("Application: Donate to: Political causes")     { |user| user.etkh_application.nil? ? nil : user.etkh_application[:causes_political] }
    column ("Application: Doing Good Inspiring?")           { |user| user.etkh_application.nil? ? nil : user.etkh_application[:doing_good_inspiring] }
    column ("Application: Doing Good Research?")            { |user| user.etkh_application.nil? ? nil : user.etkh_application[:doing_good_research] }
    column ("Application: Doing Good Philanthropy?")        { |user| user.etkh_application.nil? ? nil : user.etkh_application[:doing_good_philanthropy] }
    column ("Application: Doing Good ProPhilanthropy??")    { |user| user.etkh_application.nil? ? nil : user.etkh_application[:doing_good_prophilanthropy] }
    column ("Application: Doing Good Improving?")           { |user| user.etkh_application.nil? ? nil : user.etkh_application[:doing_good_improving] }

    column ("Profile: Inspiration")                         { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:inspiration] }
    column ("Profile: Occupation")                          { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:occupation] }
    column ("Profile: Organisation")                        { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:organisation] }
    column ("Profile: Background")                          { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:background] }
    column ("Profile: Career Plans")                        { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:career_plans] }
    column ("Profile: Organisation")                        { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:organisation] }
    column ("Profile: Organisation role")                   { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:organisation_role] }
    column ("Profile: Doing Good Inspiring?")               { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:doing_good_inspiring] }
    column ("Profile: Doing Good Research?")                { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:doing_good_research] }
    column ("Profile: Doing Good Philanthropy?")            { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:doing_good_philanthropy] }
    column ("Profile: Doing Good ProPhilanthropy??")        { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:doing_good_prophilanthropy] }
    column ("Profile: Doing Good Improving?")               { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:doing_good_improving] }
  end
end
