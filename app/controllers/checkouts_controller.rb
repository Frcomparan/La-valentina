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
              },
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
              },
            },
            quantity: 2
          }
      ],
        success_url: checkout_success_url
      )
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
  end
end
