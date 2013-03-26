class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Idea
    can :create, Idea if user
    can [:update, :destroy], Idea, :user_id => user.id
  end
end
