# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[private admin_users]

  def home; end
end
