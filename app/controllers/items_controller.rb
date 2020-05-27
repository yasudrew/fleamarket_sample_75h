class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.build_shipping
    @item.build_brand
    render layout: 'sub_application'
  end

  def show
  end

  def create
    @item = Item.create(item_params)
    if @item.save!
      shipping_id = Shipping.find(@item.id).id 
      item = Item.find(@item.id)            
      item.update(shipping_id: shipping_id)
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
    category_ids: [],brand_attributes: [:id ,:name], user_id: [:nickname, :email, :password],shipping_attributes:[:id,:burden, :method, :area, :day])
  end
end
