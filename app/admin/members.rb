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
               #:apply_reasons_for_joining,
               #:apply_heard_about_us,
               :apply_spoken_to_existing_member,
               :apply_career_plans,
               :real_name,
               :donation_percentage,
               :donation_average_income,
               :donation_hic_activity_hours,
               :parallel_universe_donation_percentage,
               :parallel_universe_donation_average_income,
               :parallel_universe_donation_hic_activity_hours,
               :parallel_universe_occupation,
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

  # for History sidebar in show view
  controller do
    def show
        @member = Member.find(params[:id])
        @versions = @member.versions
        @member = @member.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versions, :partial => "admin/version_sidebar", :only => :show
end
