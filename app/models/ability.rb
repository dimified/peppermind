class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Challenge
    can :read, Challenge
    can :create, Challenge if user
    can :update, Challenge, :user_id => user.id

    # Inspiration
    can :read, Inspiration
    can :create, Inspiration if user
    can [:update, :destroy], Inspiration, :user_id => user.id
  end
end
