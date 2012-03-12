class EndorsementsController < ApplicationController
  def index
    @endorsements = Endorsement.endorsement_page.order("created_at DESC")
    @menu_current = 'Endorsements'
    @menu_root = 'About Us'
  end
end
