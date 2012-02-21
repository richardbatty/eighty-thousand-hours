ActiveAdmin.register EthApplication do
  menu :if => proc{ can?(:read, Member) }
  controller.authorize_resource

  action_item :only => :show do
    link_to "Confirm member", confirm_admin_member_path(eth_application.member), :method => :put
  end
end
