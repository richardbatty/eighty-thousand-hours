When /^I enter a comment$/ do
  @comment_text = 'My new comment'
  fill_in('comment-body', with: @comment_text)
end

Then /^I should see the comment$/ do
  page.should have_content(@comment_text)
end
