class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      if Role.pluck(:name).include?(user.roles.first.try(:name))
        send("#{user.roles.first.name}_abilities")
      else
        guest_abilities
      end
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def seller_abilities
    can :read, Item
  end

  def contractor_abilities
    can :read, Item
  end

  def guest_abilities
    can :read, Product
  end
end
