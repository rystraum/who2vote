class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :rails_admin
    can :dashboard
    can :manage, :all
    cannot :manage, User unless user.email == "rystraum@gmail.com"
  end
end
