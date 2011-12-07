class PagesController < ApplicationController
  def index
    @pages = Page.all
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @pages }
    end
  end
  def show
    @page = Page.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @page }
    end
  end


  def edit
    @page = Page.find(params[:id])
  end
  def update
    @page = Page.find(params[:id])
   
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html  { redirect_to(@page,
                      :notice => 'Page was successfully updated.') }
        format.json  { render :json => {}, :status => :ok }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @page.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def new
    @page = Page.new
   
    #respond_to do |format|
    #  format.html  # new.html.erb
    #  format.json  { render :json => @page }
    #end
  end
  
  def create
    @page = Page.new(params[:page])
   
    respond_to do |format|
      if @page.save
        format.html  { redirect_to(@page,
                      :notice => 'Page was successfully created.') }
        format.json  { render :json => @page,
                      :status => :created, :location => @page }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @page.errors,
                      :status => :unprocessable_entity }
      end
    end
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
