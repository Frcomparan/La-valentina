# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[private]

  def home; end

  def private; end
end
