class InfoController < ApplicationController
  def index
    @title = "Home"

    # for profile photos on front page
    begin
      ids = [28,27,26,24,38,43,44,45,14,25]
      @members = Member.find( (ids.shuffle)[0..5] ).shuffle
    rescue
      @members = Member.get_random( 6 )
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

  def join
    @title = "Join"
  end

  def application_faq
    @title = "Application FAQ"
  end

  def coming_soon
    @title = "Coming soon!"
  end

  def career_profiles
    @title = "Career profiles"
  end
  
  def meet_the_team
    @title = "Meet the team"
    ids = [13,24,26,27,29,46,47,49,51]
    @team = Member.find( ids ).shuffle
  end

  def banker_vs_aid_worker
    @title = "Banker vs Aid Worker"
  end

  def op_ed
    @title = "Banker vs Aid Worker: Op-Ed"
  end

  def q_and_a
    @title = "Banker vs Aid Worker: Q & A"
  end

  def inspiring_others
    @title = "Inspiring others"
  end
end
