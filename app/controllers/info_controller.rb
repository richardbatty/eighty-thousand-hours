class InfoController < ApplicationController
  def index
  end

  def what_you_can_do
  end

  def ethical_career
  end

  def my_donations
  end

  def my_career
  end

  def what_we_do
  end
  
  def get_involved
  end

  def volunteer
  end

  def faq
  end

  def join
  end

  def events
    @gcal_params = "orderby=starttime&futureevents=true"
  end

  def past_events
    # start-min default unix epoch, use tomorrow (instead of today)
    # to cover our backs
    @gcal_params = 'orderby=starttime&start-max=' + Date.tomorrow.rfc3339 
    render :events
  end

  def orbis_stockpicking_challenge
  end

  def career_research
  end

  def members
  end

  def volunteer
  end
end
