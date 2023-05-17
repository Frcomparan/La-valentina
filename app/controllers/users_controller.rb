class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def admin_users
    @users = User.all
  end
end
