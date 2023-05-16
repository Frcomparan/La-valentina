# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :current_cart

  def set_locale
    I18n.locale = 'es'
  end

  protected

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "No puedes acceder a esta página"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def current_cart
    @current_cart = nil
    return unless user_signed_in?
    if session[:cart_id]
      cart = Cart.find_by(:id => session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id] == nil
      @current_cart = current_user.carts.find_by(status: 0)
      @current_cart = current_user.carts.create if @current_cart.nil?

      session[:cart_id] = @current_cart.id
    end
  end
end
