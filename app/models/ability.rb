# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Course

    return unless user.present?

    return unless user.admin?

  end
end
