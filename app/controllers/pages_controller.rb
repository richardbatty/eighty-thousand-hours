class PagesController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
 
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
    
    if @page.title == "Home"
      # for profile photos on front page
      begin
        ids = [28,27,26,24,38,43,44,45,14,25]
        @members = Member.find( (ids.shuffle)[0..9] ).shuffle
      rescue
        @members = Member.limit( 10 )
      end

      render :home
    end

    #otherwise render show.html...
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
   
    if @page.update_attributes(params[:page])
       redirect_to(@page, :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
   
    if @page.save
       redirect_to(@page, :notice => 'Page was successfully created.')
    else
      render :action => "new"
    end
  end

  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
  def get_user
    @current_user = current_user
  end

  #def index
  #  @pages = Page.all
  #  #render :show
  #end

  #def show
  #  @page = getContent(params[:slug])
  #  if !@page
  #    render :error
  #  end
  #end

  #private
  #def getContent( slug )
  #  page = Page.find_by_slug(slug)
  #end


  #def index
  #  @title = "Home"

  #  # for profile photos on front page
  #  begin
  #    ids = [28,27,26,24,38,43,44,45,14,25]
  #    @members = Member.find( (ids.shuffle)[0..5] ).shuffle
  #  rescue
  #    @members = Member.limit( 6 )
  #  end
  #end
  
  #def events
  #  @gcal_params = "orderby=starttime&futureevents=true"
  #  @title = "Events"
  #end

  #def past_events
  #  # we don't specify a 'start-min' as it defaults to Unix epoch
  #  # we set start-max to tomorrow to make sure we catch everything
  #  @gcal_params = 'orderby=starttime&start-max=' + Date.tomorrow.rfc3339 
  #  @title = "Past events"
  #  render :events
  #end
  
  #def meet_the_team
  #  @title = "Meet the team"
  #  team_roles = %w[president managing_director research community
  #                  communications fundraising tech other]
  #  @team_profiles = team_roles.inject({}) do |profiles, role|
  #    role = role.humanize.titleize
  #    profiles[role] = Member.with_team_role(role)
  #    profiles
  #  end
  #end
end
