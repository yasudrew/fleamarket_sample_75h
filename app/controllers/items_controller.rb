class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.build_shipping
    @item.build_brand
    @item.images.build
    @item.build_category
    render layout: 'sub_application'
  end

  def show
    @item = Item.new
  end

  def create
    fee = item_params[:price].to_i * 0.1
    profit = item_params[:price].to_i - fee
    @item = Item.new(item_params.merge(fee: fee, profit: profit))
    if @item.save
      redirect_to root_path
   else
      redirect_to new_item_path
      #flash.now[:alert] = ‘登録に失敗しました。お手数ですが、もう一度やり直してください。’
   end
  end

  def purchase_confirmation
    render layout: 'sub_application'
  end
  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:price,:buyer_id,
    category_attributes: [:id,:name], brand_attributes: [:id ,:name], user_id: [:nickname, :email, :password],shipping_attributes:[:id,:burden, :method, :area, :day],
    images_attributes:[:id,:image])
    .merge(user_id: current_user.id)
  end
end
