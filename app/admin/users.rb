ActiveAdmin.register User do
  menu :if => proc{ can?(:manage, User) }
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

    column ("Profile: Background")                          { |user| user.etkh_profile.nil? ? nil : user.etkh_profile[:background] }
  end
end
