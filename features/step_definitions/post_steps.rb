Given /^there is a post$/ do
  @post ||= FactoryGirl.create :post
end

Given /^I am viewing the post$/ do
  visit post_path @post
end
