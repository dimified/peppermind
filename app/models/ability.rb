class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Challenge
    can :create, Challenge if user
    can [:update, :destroy], Challenge, :user_id => user.id
  end
end
