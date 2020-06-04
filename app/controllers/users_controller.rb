class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def my_favorites
    @items = current_user.favorite_items
  end

  def my_items
    @items = current_user.items
  end

  def my_purchased_items
    @items = Item.where(buyer_id: current_user.id)
  end
end
