Given /^I am a donation admin$/ do
  @user ||= FactoryGirl.create :donation_manager
  FactoryGirl.create :page # dummy home page to make views work
  sign_in
end

Given /^there is a member$/ do
  @member ||= FactoryGirl.create :member
end

Given /^there is a cause$/ do
  @cause ||= FactoryGirl.create :cause
end

When /^I create a donation$/ do
  visit(new_admin_donation_path)
  fill_in("Amount", with: 10)
  select(@member.name, from: 'Member')
  select(@cause.name, from: 'cause')
  click_button('Create Donation')
end

Then /^(?:|I )should see the donation$/ do
  page.should have_content(@cause.name)
  page.should have_content(@member.name)
  page.should have_content(10)
end

Then /^there should be (\d+|no) donations?$/ do |count|
  Donation.count.should == count.to_i
end

Then /^the donation total should not be zero$/ do
  Donation.sum('amount').should_not == 0
end
