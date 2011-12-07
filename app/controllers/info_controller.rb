class InfoController < ApplicationController
  def index
    @title = "Home"

    # for profile photos on front page
    begin
      ids = [28,27,26,24,38,43,44,45,14,25]
      @members = Member.find( (ids.shuffle)[0..5] ).shuffle
    rescue
      @members = Member.limit( 6 )
    end
  end
  
  def events
    @gcal_params = "orderby=starttime&futureevents=true"
    @title = "Events"
  end

  def past_events
    # we don't specify a 'start-min' as it defaults to Unix epoch
    # we set start-max to tomorrow to make sure we catch everything
    @gcal_params = 'orderby=starttime&start-max=' + Date.tomorrow.rfc3339 
    @title = "Past events"
    render :events
  end

  def meet_the_team
    @title = "Meet the team"
    team_roles = %w[president managing_director research community
                    communications fundraising tech other]
    @team_profiles = team_roles.inject({}) do |profiles, role|
      role = role.humanize.titleize
      profiles[role] = Member.with_team_role(role)
      profiles
    end
  end

  def what_you_can_do
    @title = "What you can do"
  end

  def ethical_career
    @title = "Ethical career?"
  end

  def my_donations
    @title = "My donations"
  end

  def my_career
    @title = "My career"
  end

  def what_we_do
    @title = "What we do"
  end
  

  def inspiring_others
    @title = "Inspiring others"
  end

  def giving_more
    @title = "Giving more"
  end
end
