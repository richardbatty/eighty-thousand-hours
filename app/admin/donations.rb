ActiveAdmin.register Donation do
  menu :if => proc{ can?(:manage, Donation) },
       :parent => "Charities"

  index do
    column :id
    column :created_at
    column :amount
    column :charity do |donation|
      donation.charity.name
    end
    column :member do |donation|
      donation.user.name if donation.user
    end
    column :receipt do |donation|
      if donation.receipt?
        link_to 'View receipt', donation.receipt.url(:thumb)
      end
    end
    default_actions
  end

  show do |donation|
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :charity
      row :amount
      row :user
      row :receipt do
        if donation.receipt?
          link_to 'View receipt', donation.receipt.url(:thumb)
        end
      end
      row :confirmed
    end
  end

  form do |f|
    f.inputs :user,
             :charity,
             :amount,
             :receipt
    f.buttons
  end

  # Available at /admin/donations/:id/confirm and #confirm_admin_post_path(donation)
  member_action :confirm, :method => :put do
    donation = Donation.find(params[:id])
    donation.confirm!
    redirect_to admin_donation_path(donation), :notice => "Donation confirmed!"
  end

  action_item :only => :show do
    if !donation.confirmed
      link_to "Confirm donation", confirm_admin_donation_path(donation), :method => :put
    end
  end
end
