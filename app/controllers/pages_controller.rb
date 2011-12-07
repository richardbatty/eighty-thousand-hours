class PagesController < ApplicationController
  def index
    @title,@body = getContent( "home" )
    render :show
  end

  def show
    @title,@body = getContent(params[:page_slug])
  end

  private
  def getContent( slug )
    page = Page.find_by_slug(slug)
    title = page.title
    body = page.body
    return [title,body]
  end


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
