When /^I connect to Facebook$/ do
  click_link 'fb-connect'
end

Then /^I have a new authentication$/ do
  @user.authentications.size.should eq 1
end

Then /^I can see the authentication on my account settings page$/ do
  page.should have_content("Your account is linked to facebook")
end

Given /^I have an authentication$/ do
  @authentication ||= FactoryGirl.create( :authentication, user: @user )
end

Given /^my Facebook email is the same as my account email$/ do
  set_omniauth info: {email: @user.email}
end

When /^I merge my account$/ do
  fill_in("user_email",    with: @user.email)
  fill_in("user_password", with: @user.password)
  click_button "Sign in"

  # should now be on account settings page
  page.should have_content('Account settings')
  click_link 'fb-connect'
end

And /^I create an account$/ do
  click_link 'Connect to Facebook'
end

Given /^I am an unknown visitor$/ do
end

Then /^I get an email$/ do
  pending # express the regexp above with the code you wish you had
end
