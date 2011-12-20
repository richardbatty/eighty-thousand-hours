Given /^I am a donation admin$/ do
  @user ||= FactoryGirl.create :donation_manager
  FactoryGirl.create :page # dummy home page to make views work
  sign_in
end

Given /^there is a member$/ do
  @member ||= FactoryGirl.create :member
end

Given /^there is a charity$/ do
  @charity ||= FactoryGirl.create :charity
end

When /^I create a donation$/ do
  visit(new_admin_donation_path)
  fill_in("Amount", with: 10)
  select(@member.name, from: 'Member')
  select(@charity.name, from: 'Charity')
  click_button('Create Donation')
end

Then /^(?:|I )should see the donation$/ do
  page.should have_content(@charity.name)
  page.should have_content(@member.name)
  page.should have_content(10)
end

Then /^there should be (\d+|no) donations?$/ do |count|
  Donation.count.should == count.to_i
end

Then /^the donation total should not be zero$/ do
  Donation.sum('amount').should_not == 0
end