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

    # a MemberAdmin can manage all member profiles
    elsif user.has_role? :member_admin
      can :access, :admin
      can :manage, User
      can :manage, Member

    # a BlogAdmin can manage all blog posts
    elsif user.has_role? :blog_admin
      can :access, :admin
      can :manage, Post
      can :manage, Page, :slug => "recommended-posts"

    # a DonationAdmin manages donations and charities
    elsif user.has_role? :donation_admin
      can :access, :admin
      can :manage, Donation
      can :manage, Charity

    # a WebAdmin can edit and create site content pages
    elsif user.has_role? :web_admin
      can :manage, Page
      can :manage, Endorsement
    else
    end
    can :read, Post, :published => true
    can :read, Page
  end
end
