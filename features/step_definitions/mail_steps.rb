Then /^I am sent an email$/ do
  last_email.to.should include(@user.email)
end
