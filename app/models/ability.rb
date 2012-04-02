class Ability
  include CanCan::Ability
  
  def initialize(user)
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)

    # an Admin can do anything
    if user.has_role? :admin
      can :access, :admin
      can :manage, :all
    end

    # a MemberAdmin can manage all member profiles
    if user.has_role? :member_admin
      can :access, :admin
      can :manage, User
      can :manage, EightyThousandHoursApplication
    end

    # a MemberViewer can read all member profiles
    if user.has_role? :member_viewer
      can :access, :admin
      can :read, User
    end

    # a BlogAdmin can manage all blog posts
    if user.has_role? :blog_admin
      can :access, :admin
      can :manage, Post
      can :manage, Page, :slug => "recommended-posts"
    end

    # a BlogAdmin can manage all blog posts
    if user.has_role? :endorsement_admin
      can :access, :admin
      can :manage, Endorsement
    end

    # a DonationAdmin manages donations and charities
    if user.has_role? :donation_admin
      can :access, :admin
      can :manage, Donation
      can :manage, Charity
    end

    # a WebAdmin can edit and create site content pages
    if user.has_role? :web_admin
      can :access, :admin
      can :manage, Page
    end

    if user
      can :update, User, :id => user.id

      if user.confirmed?
        can :manage, Donation, :user_id => user.id
        can :create, Charity
        can :create, Post
        can :manage, Post, :user_id => user.id
      end
    end

    # anyone can read posts or view pages
    can :read, Post, :published => true
    can :read, Page
  end
end
