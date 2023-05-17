# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Course
    can [:default, :show, :destroy], Cart

    return unless user.present?
    can :my_courses, Course
    can :read, Lesson do |item|
      user.bought_courses.include?(item.course)
    end


    return unless user.admin?
    can :manage, :all
    can :read, Lesson
    can [:create, :update, :destroy, :admin_courses], [Course, Lesson]
  end
end
