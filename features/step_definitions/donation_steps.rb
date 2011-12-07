Given /^I am a donation admin$/ do
  @user ||= FactoryGirl.create :donation_manager
  sign_in
end

When /^I create a donation$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^there should be (\d+|no) donation?$/ do |count|
  Donation.count.should == count.to_i
end

Then /^the donation total should not be zero$/ do
  Donation.sum.should_not == 0
end