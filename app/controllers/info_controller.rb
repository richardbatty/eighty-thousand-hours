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
    # we don't specify a 'start-min' as it defaults to Unix epoch
    # we set start-max to tomorrow to make sure we catch everything
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

  def pledge
    @title = "The Pledge"
  end

  def contact_us
    @title = "Contact us"
  end

  def help
    @title = "Help"
  end

  def find_out_more
    @title = "Find out more"
  end
  
  def show_your_support
    @title = "Show your support"
  end

  def blog
    @title = "Blog"
  end
  
  def press
    @title = "Press"
  end
end
