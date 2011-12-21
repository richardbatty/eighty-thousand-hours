Then /^I am sent an email$/ do
  last_email.to.should include(@user.email)
end

Then /^the member should be emailed$/ do
  last_email.to.should include(@member.email)
end
