class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def my_favorites
    @items = current_user.favorite_items
  end
end
