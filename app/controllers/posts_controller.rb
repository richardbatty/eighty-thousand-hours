class PostsController < ApplicationController
  def index
    @posts = Post.published.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @post = Post.find(params[:id])
    @og_url = post_url( @post )
    @og_desc = @post.get_teaser
    @og_type = "article"
    @title = "Blog: " + @post.title
  end

  # Atom feed
  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "80,000 Hours - Blog"

    # the blog posts
    @posts = Post.published

    # this will be our feed's update timestamp
    @updated = @posts.first.updated_at unless @posts.empty?

    respond_to do |format|
      format.atom { render :layout => false } #views/posts/feed.atom.builder
    end
  end
end
