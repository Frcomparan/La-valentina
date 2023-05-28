# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer
    @course = Course.first

    @checkout_session = current_user
                        .payment_processor
                        .checkout(
                          mode: 'payment',
                          line_items: [
                            {
                              price_data: {
                                currency: 'mxn',
                                unit_amount: (@course.price * 100).to_i,
                                product_data: {
                                  name: @course.name,
                                  description: @course.description
                                }
                              },
                              quantity: 1
                            },
                            {
                              price_data: {
                                currency: 'mxn',
                                unit_amount: (@course.price * 100).to_i,
                                product_data: {
                                  name: @course.name,
                                  description: @course.description
                                }
                              },
                              quantity: 2
                            }
                          ],
                          success_url: checkout_success_url
                        )
  end

  def cart_success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
    @current_cart.update(status: 1)
    @cart = @current_cart
  end

  def now_success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])

    cart_item = CartItem.new
    @cart = current_user.carts.create(status: 1)
    course = Course.find_by(name: @line_items.data[0].description)
    cart_item.cart = @cart
    cart_item.course = course
    @current_cart.cart_items.each do |item|
      if item.course_id == course.id
        item.destroy
      end
    end
    cart_item.save
  end
end
