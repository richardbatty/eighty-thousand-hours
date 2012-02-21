ActiveAdmin.register ApplyTo80kForm do
  menu :if => proc{ can?(:read, Member) }
  controller.authorize_resource

  action_item :only => :show do
    link_to "Confirm member", confirm_admin_member_path(apply_to_80k_form.member), :method => :put
  end
end
