And /^I should see the join page$/ do
  page.should have_content("I declare that I aim to pursue a career as an effective altruist.")
  page.should have_content("Joining 80,000 Hours")
end

When /^I fill in the application form$/ do
  fill_in('Career plans',               with: "Some plans I have...")
  fill_in('What do you currently do?',  with: "I am a layabout")
  check('I agree to the declaration')
  click_button('Apply to join 80,000 Hours')
end

And /^I have applied to join 80,000 Hours$/ do
  @eighty_thousand_hours_application ||= FactoryGirl.create :eighty_thousand_hours_application
  @user.eighty_thousand_hours_application = @eighty_thousand_hours_application
  @user.save
end
