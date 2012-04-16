class AddOmniAuthSignupToUser < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_signup, :boolean, :default => false
  end
end
