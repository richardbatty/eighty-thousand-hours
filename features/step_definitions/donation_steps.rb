Given /^there is a member$/ do
  @member ||= FactoryGirl.create :member
end

Given /^there is a charity$/ do
  @charity ||= FactoryGirl.create :charity
end

Given /^I am a donation admin$/ do
  @user ||= FactoryGirl.create :donation_manager
  sign_in
end

When /^I create a donation$/ do
  visit(new_admin_donation_path)
  fill_in()
  select(@member.name, :from => 'Member')
  pending # express the regexp above with the code you wish you had
end

Then /^there should be (\d+|no) donation?$/ do |count|
  Donation.count.should == count.to_i
end

Then /^the donation total should not be zero$/ do
  Donation.sum.should_not == 0
end