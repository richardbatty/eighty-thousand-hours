ActiveAdmin.register Member do
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
               :avatar
      f.buttons
    end
  end
end
