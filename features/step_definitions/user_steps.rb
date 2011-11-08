def sign_in(options = {})
  options = options.reverse_merge user: @user
  
  visit new_user_session_path
  fill_in("user_email", with: options[:user].email)
  fill_in("user_password", with: options[:user].password)
  click_button("Sign in")
end

def sign_out
  visit destroy_user_session_path
end

Given /^(?:|I )am signed in$/i do
  @user ||= FactoryGirl.create :user
  sign_in
end

Given /^(?:|I )am signed out$/i do
  sign_out
end

When /^(?:|I )enter my details$/i do
  @user ||= FactoryGirl.build :user
  fill_in 'user_name', with: @user.name
  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
end

When /^(?:|I )take the pledge/i do
  check 'user_pledge'
end

When /^(?:|I )enter my email and password$/ do
  fill_in 'email', with: @user.email
  fill_in 'password', with: @user.password
end

Then /^there should be ([0-9]+|no) users?$/ do |count|
  User.count.should == count.to_i
end
