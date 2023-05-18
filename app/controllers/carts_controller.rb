# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_session, only: %i[show]
  load_and_authorize_resource

  def default
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def admin_sales
    @sales = if params[:filter].nil?
               Cart.all.where(status: 1).order(:id)
             else
               Cart.search_filter(params[:filter])
             end
  end

  def show
    @cart = @current_cart
  end

  def sale
    @cart = Cart.find(params[:id])
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  private

  def create_session
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

    return if @current_cart.cart_items.length <= 0

    line_items = []
    @current_cart.cart_items.each do |item|
      line_items.push(
        {
          price_data: {
            currency: 'mxn',
            unit_amount: (item.course.price * 100).to_i,
            product_data: {
              name: item.course.name,
              description: item.course.description
            }
          },
          quantity: 1
        }
      )
    end

    @checkout_session = current_user
                        .payment_processor
                        .checkout(
                          mode: 'payment',
                          line_items:,
                          success_url: checkout_cart_success_url
                        )
  end
end
