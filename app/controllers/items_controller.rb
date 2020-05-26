class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    render layout: 'sub_application'
  end

  def show
  end

  def create
    Item.create(item_params)
  end

  def purchase_confirmation
    render layout: 'sub_application'
  end
  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:price,:fee,:profit,:buyer_id,
    category_id: [:name,:ancestry],brand_id: [:name], user_id: [:nickname, :email, :password],shipping_id:[:burden, :type, :area, :day])
  end
end
