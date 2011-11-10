class InfoController < ApplicationController
  def index
  end

  def what_you_can_do
    @title = "What You Can Do"
  end

  def ethical_career
    @title = "Ethical Career?"
  end

  def my_donations
    @title = "My Donations"
  end

  def my_career
    @title = "My Career"
  end

  def what_we_do
    @title = "What We Do"
  end
  
  def get_involved
    @title = "Get Involved"
  end

  def volunteer
    @title = "Volunteer"
  end

  def faq
    @title = "F.A.Q."
  end

  def join
    @title = "Join"
  end

  def events
    @gcal_params = "orderby=starttime&futureevents=true"
    @title = "Events"
  end

  def past_events
    # start-min default unix epoch, use tomorrow (instead of today)
    # to cover our backs
    @gcal_params = 'orderby=starttime&start-max=' + Date.tomorrow.rfc3339 
    @title = "Past Events"
    render :events
  end

  def orbis_stockpicking_challenge
    @title = "Orbis Stockpicking Challenge"
  end

  def career_research
    @title = "Career Research"
  end

  def members
    @title = "Member Profiles"
  end

  def volunteer
    @title = "Volunteer"
  end
end
