class InfoController < ApplicationController
  def index
    @title = "Home"
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
  
  def get_involved
    @title = "Get involved"
  end

  def volunteer
    @title = "Volunteer"
  end

  def faq
    @title = "FAQ"
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
    @title = "Past events"
    render :events
  end

  def orbis_stockpicking_challenge
    @title = "Orbis stockpicking challenge"
  end

  def career_research
    @title = "Career research"
  end

  def members
    @title = "Member profiles"
  end

  def volunteer
    @title = "Volunteer"
  end
end
