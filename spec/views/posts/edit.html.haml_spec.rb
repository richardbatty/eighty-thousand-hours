require 'spec_helper'

describe "posts/edit.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "MyString",
      :body => "MyText",
      :draft => false
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path(@post), :method => "post" do
      assert_select "input#post_title", :name => "post[title]"
      assert_select "textarea#post_body", :name => "post[body]"
      assert_select "input#post_draft", :name => "post[draft]"
    end
  end
end
