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
    if user.has_role? :admin
      can :access, :admin
      can :manage, :all
    elsif user.has_role? :member_admin
      can :access, :admin
      can :manage, User
      can :manage, Member
    elsif user.has_role? :blogger
      can :access, :admin
      # can :manage, Post, :user_id => user.id
      can :manage, Post
      can :manage, Page, :slug => "recommended-posts"
      # can :read, :all
    elsif user.has_role? :donation_admin
      can :access, :admin
      can :manage, Donation
      can :manage, Charity
    elsif user.has_role? :WebEditor
      can :manage, Page
    else
    end
    can :read, Post, :published => true
    can :read, Page
  end
end
