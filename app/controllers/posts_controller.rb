class PostsController < ApplicationController
  def index
    @posts = Post.published.paginate(:page => params[:page], :per_page => 10)
    @recommended_posts = Page.find('recommended-posts')
    @title = "Blog"
    @tags = Post.tag_counts_on(:tags) || []

    # When we upgrade to Rails3.2 this becomes Post.select(:author).uniq...
    @authors = Post.select('DISTINCT author').order('author ASC')
  end

  def show
    @post = Post.find_by_id(params[:id])
    @og_url = post_url( @post )
    @og_desc = @post.get_teaser
    @og_type = "article"
    @title = "Blog: " + @post.title
    @recommended_posts = Page.find('recommended-posts')

    # When we upgrade to Rails3.2 this becomes Post.select(:author).uniq...
    @authors = Post.select('DISTINCT author').order('author ASC')

    @tags = @post.tag_list
  end

  def author
    @heading = "Posts by #{params[:id]}"
    @posts = Post.published.where("author = ?", params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @recommended_posts = Page.find('recommended-posts')
    @tags = Post.tag_counts_on(:tags) || []

    # When we upgrade to Rails3.2 this becomes Post.select(:author).uniq...
    @authors = Post.select('DISTINCT author').order('author ASC')

    render :action => 'index'
  end

  def tag
    @heading = "Posts tagged with '#{params[:id]}'"
    @posts = Post.tagged_with(params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @tags = Post.tag_counts_on(:tags)
    @recommended_posts = Page.find('recommended-posts')

    # When we upgrade to Rails3.2 this becomes Post.select(:author).uniq...
    @authors = Post.select('DISTINCT author').order('author ASC')

    render :action => 'index'
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
