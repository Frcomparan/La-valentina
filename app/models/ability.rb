# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Course

    return unless user.present?
    can :my_courses, Course


    return unless user.admin?
    can :read, Lesson
    can [:create, :update, :destroy, :admin_courses], [Course, Lesson]
  end
end
