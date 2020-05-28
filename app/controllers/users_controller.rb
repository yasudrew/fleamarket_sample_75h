class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def address_page
    
  end
end
