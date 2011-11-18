class MembersController < ApplicationController
  def index
    @members = MemberProfile.find( :all, :include => :user )
  end
end
