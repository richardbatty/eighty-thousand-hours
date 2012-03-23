When /^I connect to Facebook$/ do
  set_omniauth
  click_link 'fb-connect'
end

Then /^I have a new authentication$/ do
  @user.authentications.size.should eq 1
end

Then /^I can see the authentication on my account settings page$/ do
  page.should have_content("Your account is linked to facebook")
end

Given /^I have an account$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have an authentication$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I am logged in$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^my Facebook email is the same as my account email$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I merge my account$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I am an unknown visitor$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I create an account$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I get an email$/ do
  pending # express the regexp above with the code you wish you had
end
