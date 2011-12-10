class PostsController < ApplicationController
  def index
    @posts = Post.published

    respond_to do |format|
      format.html # index.html.erb
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def show
    @post = Post.find(params[:id])
    @og_url = post_url( @post )
    @og_desc = @post.get_teaser
    @og_type = "article"
    @title = "Blog: " + @post.title
  end
end
