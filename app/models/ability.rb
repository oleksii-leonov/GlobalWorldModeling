class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :read, :all
    
    if user
      can :manage, Model, :user_id => user.id
      can [:read, :create], Model
      can :manage, KnownValue, :user_id => user.id
      can [:read, :create], KnownValue
    end
    
  end
end