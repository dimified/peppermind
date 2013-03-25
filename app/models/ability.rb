class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Idea
    can :update, Idea, :user_id => user.id
  end
end
