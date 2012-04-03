class PostsController < ApplicationController
  load_and_authorize_resource :only => [:new,:create,:edit,:update,:destroy]

  def prepare_sidebar
    @recommended_posts = Page.find('recommended-posts')
    @tag_cloud = Post.tag_counts_on(:tags) || []
    @popular_posts = Post.by_popularity(5)
    @authors = Post.author_list
  end

  def index
    @sort = params[:order]
    case @sort
    when 'popularity'
      @posts = Post.by_popularity
      @condensed = true
      @heading = "Most popular posts"
    when 'votes'
      @posts = Post.by_votes
      @condensed = true
      @heading = "Highest voted posts"
    when 'date'
      @posts = Post.published
      @condensed = true
      @heading = "All posts by date"
    else
      @posts = Post.published.paginate(:page => params[:page], :per_page => 10)
      @condensed = false
      @heading = "80,000 Hours blog"
    end

    @title = "Blog"
    @menu_root = "Blog"
    
    prepare_sidebar
  end

  def sorted
    @posts = Post.by_votes

    @title = "Most popluar posts of all time"
    @menu_root = "Blog"
    @condensed = params[:condensed]
    
    prepare_sidebar
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      flash[:"alert-error"] = "Sorry! You've followed a bad link, please <a href='contact-us'>contact support</a> and report the following:<br/> #{params[:controller]} => '#{params[:id]}'".html_safe
      redirect_to :action => 'index'
    else
      if @post.draft
        if cannot? :manage, Post
          # user is not allowed to view drafts
          # so we redirect to the index
          flash[:"alert-error"] = "Sorry! You've followed a bad link, please <a href='contact-us'>contact support</a>!".html_safe
          redirect_to :action => 'index'
        end
      end

      @og_url = post_url( @post )
      @og_desc = @post.get_teaser
      @og_type = "article"
      @title = "Blog: " + @post.title
      @tags = @post.tag_list

      @menu_root = "Blog"

      prepare_sidebar
    end
  end

  def author
    @heading = "Posts by #{params[:id]}"
    @posts = Post.by_author(params[:id],params[:page])
    @condensed = true

    prepare_sidebar

    render :action => 'index'
  end

  def vote
    post = Post.find( params[:id] )
    user = current_user
    
    if !user
      flash[:"alert-warn"] = "You need to sign in or sign up to vote!"
    else
      post.vote!( user, (params[:up] == 'true') ? true : false )
    end

    redirect_to :action => 'index' 
  end

  def tag
    @heading = "Posts tagged with '#{params[:id]}'"
    @posts = Post.tagged_with(params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @condensed = true

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

  def edit
    @post = Post.find( params[:id] )
    2.times { @post.attached_images.build }
  end

  def update
    @post = Post.find( params[:id] )
    if @post.update_attributes( params[:post] )
      redirect_to @post, :notice => "Post updated!"
    else
      render :edit
    end
  end

  def new
    @post = Post.new
    2.times { @post.attached_images.build }
  end

  def create
    @post = current_user.posts.new( params[:post] )
    if @post.save
      redirect_to @post, :notice => "Blog post created!"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find( params[:id] )
    @post.destroy
    redirect_to posts_path, :notice => "Post permanently deleted"
  end

  private
  def can_vote_on_post? (user, post )
    !user.nil?
  end
end
