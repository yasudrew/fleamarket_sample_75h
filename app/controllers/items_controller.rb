class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.build_shipping
    @item.build_brand
    @item.images.build
    render layout: 'sub_application'
  end

  def show
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save!
      redirect_to root_path
   else
      redirect_to new_item_path
   end
  end

  def purchase_confirmation
    render layout: 'sub_application'
  end
  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:price,:fee,:profit,:buyer_id,
    category_attributes: [:id,:name], brand_attributes: [:id ,:name], user_id: [:nickname, :email, :password],shipping_attributes:[:id,:burden, :method, :area, :day],
    images_attributes:[:id,:image])
    .merge(user_id: current_user.id)
  end
end
