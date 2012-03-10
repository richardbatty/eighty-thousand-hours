class EndorsementsController < ApplicationController
  def index
    @endorsements = Endorsement.order("created_at ASC")
    @menu_current = 'Endorsements'
    @menu_root = 'About Us'
  end
end
