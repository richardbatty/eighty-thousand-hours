ActiveAdmin.register User do
  menu :if => proc{ can?(:manage, User) },
       :label => "Members"
  controller.authorize_resource

  filter :name
  filter :email
  filter :location

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
    column "80,000 Hours member?" do |user|
      if user.eighty_thousand_hours_member?
        "<span class='status ok'>YES</span>".html_safe
      end
    end
    column :created_at
    column "80k profile" do |user|
      link_to "80k profile", admin_etkh_profile_path(user.etkh_profile) unless user.etkh_profile.nil?
    end

    default_actions
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

    column ("Application: Occupation")                      { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:occupation] }
    column ("Application: Career Plans")                    { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:career_plans] }
    column ("Application: Spoken to existing user?")        { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:spoken_to_existing_member] }
    column ("Application: Donation percentage")             { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:donation_percentage] }
    column ("Application: Donation comment")                { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:donation_comment] }
    column ("Application: Average income")                  { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:average_income] }
    column ("Application: Income comment")                  { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:average_income_percentage] }
    column ("Application: HIC activity hours")              { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:hic_activity_hours] }
    column ("Application: HIC activity hours comment")      { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:hic_activity_hours_comment] }
    column ("Application: Donate to: GiveWell recommended") { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_givewell] }
    column ("Application: Donate to: GWWC recommended")     { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_gwwc] }
    column ("Application: Donate to: Other international")  { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_international] }
    column ("Application: Donate to: Other domestic")       { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_domestic] }
    column ("Application: Donate to: X-risk")               { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_xrisk] }
    column ("Application: Donate to: Meta")                 { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_meta] }
    column ("Application: Donate to: Animal causes")        { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_animal] }
    column ("Application: Donate to: Political causes")     { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:causes_political] }

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
