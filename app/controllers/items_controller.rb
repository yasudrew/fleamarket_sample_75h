class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @item.build_shipping
    @item.build_brand
    @item.images.build
    render layout: 'sub_application'
  end

  def show
    @item = Item.includes(:images).find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    
    if item.destroy
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = '商品の削除に失敗しました。お手数ですが、もう一度やり直してください。'
      render :show
      return
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
   else
      redirect_to new_item_path
   end
  end

  def purchase_confirmation
    @item = Item.find(params[:id])
    card = current_user.cards.first
    if card.blank?
      redirect_to controller: :cards, action: :new
      flash[:alert] = '購入にはクレジットカード登録が必要です'
      return
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)

      card_brand = @customer_card.brand      
      case card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "master-card.png"
      when "American Express"
        @card_src = "american_express.png"
      when "Diners Club"
        @card_src = "dinersclub.png"
      when "Discover"
        @card_src = "discover.png"
      end
    end
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
