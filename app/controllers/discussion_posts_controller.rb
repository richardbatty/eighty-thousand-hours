class DiscussionPostsController < ApplicationController
  load_and_authorize_resource :only => [:new,:create,:edit,:update,:destroy]

  def index
    @posts = DiscussionPost.published.paginate(:page => params[:page], :per_page => 10)
    @title = "Discussion"
    @menu_root = "Discussion"
  end

  def show
    @post = DiscussionPost.find_by_id(params[:id])
    if @post.nil?
      flash[:"alert-error"] = "Sorry! You've followed a bad link, please <a href='contact-us'>contact support</a> and report the following:<br/> #{params[:controller]} => '#{params[:id]}'".html_safe
      redirect_to :action => 'index'
    else
      if @post.draft
        if cannot? :manage, DiscussionPost
          # user is not allowed to view drafts
          # so we redirect to the index
          flash[:"alert-error"] = "Sorry! You've followed a bad link, please <a href='contact-us'>contact support</a>!".html_safe
          redirect_to :action => 'index'
        end
      end

      @og_url = discussion_post_url( @post )
      @og_type = "article"
      @title = "Discussion: " + @post.title
      @tags = @post.tag_list

      @menu_root = "Discussion"
    end
  end

  def tag
    @heading = "Posts tagged with '#{params[:id]}'"
    @posts = DiscussionPost.blog.tagged_with(params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @condensed = true

    render :action => 'index'
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "80,000 Hours - Discussion"

    # the blog posts
    @posts = DiscussionPost.published

    # this will be our feed's update timestamp
    @updated = @posts.first.updated_at unless @posts.empty?

    respond_to do |format|
      format.atom { render :layout => false } #views/posts/feed.atom.builder
    end
  end

  def edit
    @post = DiscussionPost.find( params[:id] )
  end

  def update
    @post = DiscussionPost.find( params[:id] )
    if @post.update_attributes( params[:post] )
      redirect_to @post, :notice => "Post updated!"
    else
      render :edit
    end
  end

  def new
    @post = DiscussionPost.new
  end

  def create
    @post = current_user.discussion_posts.new( params[:discussion_post] )
    if @post.save
      redirect_to discussion_posts_path, :notice => "Post created!"
    else
      render :new
    end
  end

  def destroy
    @post = DiscussionPost.find( params[:id] )
    @post.destroy
    redirect_to discussion_posts_path, :notice => "Post permanently deleted"
  end
end
