class PagesController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]
 
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
    
    # if we have set a custon header_title then we should use that
    # otherwise use the page title (which maps to the URL slug)
    @title = ((@page.header_title.to_s == '') ? @page.title : @page.header_title )

    @menu_current = @page.title
    @menu_root = @page.root.title

    if @page.title == "Home"
      # for profile photos on front page
      begin
        ids = [28, 27, 26, 24, 42, 43, 44, 16, 25, 93, 84, 78, 45]
        @members = User.find( (ids.shuffle)[0..3] ).shuffle
      rescue
        @members = User.limit( 3 )
      end

      careers = ["banker","doctor","scientist","train_driver","campaigner","teacher"]#,"worker"]
      @careers = (careers.shuffle)[0..3]

      @total_members = EightyThousandHoursProfile.all.size

      render :home
    end

    #otherwise render show.html...
  end

  def meet_the_team
    @title = "Meet the team"
    team_roles = %w[president managing_director research community
                    communications fundraising tech strategy other]
    @team_profiles = team_roles.inject({}) do |profiles, role|
      role = role.humanize.titleize
      profiles[role] = User.with_team_role(role)#.where( :public_profile => :true )
      profiles
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
   
    if @page.update_attributes(params[:page])
      flash[:"alert-success"] = "Page was successfully updated"
      redirect_to(@page)
    else
      render :action => "edit"
    end
  end

  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
     
    if @page.save
      flash[:"alert-success"] = 'Page was successfully created'
      redirect_to(@page)
    else
      render :action => "new"
    end
  end

  def destroy
    if can? :manage, Page
      @page = Page.find(params[:id])
      begin
        @page.destroy
        flash[:"alert-success"] = 'Page successfully destroyed'
      rescue
        flash[:"alert-error"] = 'Failed to destroy page'
      end
      redirect_to :action => 'index'
    end
  end

  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
  def get_user
    @current_user = current_user
  end
end
