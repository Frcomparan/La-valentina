class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Find associated product and current cart
    chosen_course = Course.find(params[:course_id])
    current_cart = @current_cart

    # If cart already has this product then find the relevant cart_item and iterate quantity otherwise create a new cart_item for this product
    unless current_cart.courses.include?(chosen_course)
      @cart_item = CartItem.new
      @cart_item.cart = current_cart
      @cart_item.course = chosen_course

      @cart_item.save
    end
    respond_to do |format|
      format.js { render inline: "location.reload();", notice: 'AA' }
    end

    # Save and redirect to cart show path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@current_cart)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:course_id, :cart_id)
  end
end
