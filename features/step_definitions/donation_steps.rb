Given /^there is a cause$/ do
  @cause ||= FactoryGirl.create :cause
end

When /^I create a donation$/ do
  visit(new_donation_path)
  select(@cause.name, from: 'Cause')
  fill_in("Amount", with: 10)
  fill_in("Date", with: "01/02/03")
  click_button('Submit donation')
end

Then /^(?:|I )should see the donation$/ do
  page.should have_content(@cause.name)
  page.should have_content(@user.name)
  page.should have_content(10)
end

Then /^there should be (\d+|no) donations?$/ do |count|
  Donation.count.should == count.to_i
end

Then /^the donation total should not be zero$/ do
  Donation.sum('amount').should_not == 0
end
