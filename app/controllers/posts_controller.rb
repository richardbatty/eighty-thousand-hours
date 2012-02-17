class PostsController < ApplicationController
  def prepare_sidebar
    @recommended_posts = Page.find('recommended-posts')
    @tag_cloud = Post.tag_counts_on(:tags) || []
    @popular_posts = Post.popular(5)

    # When we upgrade to Rails3.2 this becomes Post.select(:author).uniq...
    @authors = Post.where(:draft=>false).select('DISTINCT author').order('author ASC')
  end

  def index
    @posts = Post.published.paginate(:page => params[:page], :per_page => 10)
    @title = "Blog"

    prepare_sidebar
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.draft
      if cannot? :manage, Post
        # user is not allowed to view drafts
        # so we redirect to the index
        flash[:notice] = "Sorry! You've followed a bad link, please <a href='contact-us'>contact support</a>!".html_safe
        redirect_to :action => 'index'
      end
    end

    @og_url = post_url( @post )
    @og_desc = @post.get_teaser
    @og_type = "article"
    @title = "Blog: " + @post.title
    @tags = @post.tag_list

    prepare_sidebar
  end

  def author
    @heading = "Posts by #{params[:id]}"
    @posts = Post.published.where("author = ?", params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

    prepare_sidebar

    render :action => 'index'
  end

  def tag
    @heading = "Posts tagged with '#{params[:id]}'"
    @posts = Post.tagged_with(params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

    prepare_sidebar

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
