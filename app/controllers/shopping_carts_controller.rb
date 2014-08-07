class ShoppingCartsController < ApplicationController

  def show

  end

  def create
    @cart = ShoppingCart.new(event_id: params[:shopping_cart][:event_id],
        user_id: current_user.try(:id),
        ticket_count: params[:shopping_cart][:ticket_count])
    @cart.add!
    render :show
  end
end
