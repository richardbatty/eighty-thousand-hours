ActiveAdmin.register Donation do
  menu :if => proc{ can?(:manage, Donation) },
       :parent => "Causes"

  index do
    column :id
    column :date
    column :currency
    column :amount
    column :cause do |donation|
      donation.cause.name
    end
    column :member do |donation|
      (link_to donation.user.name, admin_user_path(donation.user)) if donation.user
    end
    column :receipt do |donation|
      if donation.receipt?
        link_to 'View receipt', donation.receipt.url(:thumb)
      end
    end
    column :confirmed do |donation|
      if donation.confirmed?
        "<span class='status ok'>YES</span>".html_safe
      else
        "<span class='status error'>No</span> (#{link_to "Confirm", confirm_admin_donation_path(donation), :method => :put})".html_safe
      end
    end
    column :public do |donation|
      donation.public? ? "yes" : "no"
    end
    column :public_amount do |donation|
      donation.public_amount? ? "yes" : "no"
    end
    default_actions
  end

  show do |donation|
    attributes_table do
      row :id
      row :date
      row :cause
      row :currency
      row :amount
      row :user
      row :receipt do
        if donation.receipt?
          link_to 'View receipt', donation.receipt.url(:thumb)
        end
      end
      row :confirmed
      row :public
      row :public_amount
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :date
      f.input :user, :collection => User.order("name ASC").all
      f.input :cause, :collection => Cause.order("name ASC").all
      f.input :currency, :collection => ['GBP','USD','EUR']
      f.input :amount
      f.input :receipt
      f.input :confirmed
      f.input :public
      f.input :public_amount
    end
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
