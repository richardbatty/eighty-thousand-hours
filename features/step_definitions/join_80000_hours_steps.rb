Then /^I should be told to signup first$/ do
  page.should have_content("Before filling in the application form you need to create an account")
end
