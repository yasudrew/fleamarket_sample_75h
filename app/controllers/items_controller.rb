class ItemsController < ApplicationController

  before_action :set_item, only:[:edit, :update]

  def index
  end

  def new
    @item = Item.new
    @item.build_shipping
    @item.build_brand
    @item.images.build
    @item.build_category
    render layout: 'sub_application'

    @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def show
    @item = Item.find(params[:id])
    @category = @item.category
    @children = @category.parent
    @parent = @children.parent
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def destroy
    if current_user.id != Item.find(params[:id]).user_id
      redirect_to item_path(params[:id])
    elsif Item.find(params[:id]).buyer_id.present?
      redirect_to item_path(params[:id])
    else
      item = Item.find(params[:id])
      
      if item.destroy
        redirect_to user_path(current_user.id)
      else
        flash.now[:alert] = '商品の削除に失敗しました。お手数ですが、もう一度やり直してください。'
        render :show
        return
      end
    end
  end

  def create
    fee = item_params[:price].to_i * 0.1
    profit = item_params[:price].to_i - fee
    @item = Item.new(item_params.merge(fee: fee, profit: profit))
    if @item.save!
      redirect_to root_path
      flash[:notice] = '出品ありがとうございます。下部の商品一覧よりご確認ください。'
    else
      redirect_to new_item_path
      flash[:alert] = '商品の出品に失敗しました。お手数ですが、もう一度やり直してください。'
    end
  end



  def search_by_ransack
  end


      
  def edit
    if current_user.id != Item.find(params[:id]).user_id
      redirect_to item_path(params[:id])
    elsif Item.find(params[:id]).buyer_id.present?
      redirect_to item_path(params[:id])
    else
      @categories = Category.where(ancestry: nil)
      @images = @item.images
      @shipping = @item.shipping
      @category = @item.category
      @children = @category.parent
      @parent = @children.parent
      gon.existing_images = Image.where(item_id: params[:id])
      render layout: 'sub_application'
    end
  end

  def destroy_existing_image
    image = Image.find(params[:id])
    if image.destroy
    else
      flash.now[:alert] = '画像の削除に失敗しました。お手数ですが、リロードしてもう一度やり直してください。'
    end
  end

  def update
    if current_user.id != Item.find(params[:id]).user_id
      redirect_to item_path(params[:id])
    elsif Item.find(params[:id]).buyer_id.present?
      redirect_to item_path(params[:id])
    else
      fee = item_params[:price].to_i * 0.1
      profit = item_params[:price].to_i - fee
      if @item.update(item_params.merge(fee: fee, profit: profit))
        redirect_to item_path(@item.id)
      else
        redirect_to edit_item_path(@item.id)
        flash[:alert] = '商品の変更に失敗しました。お手数ですが、もう一度やり直してください。'
      end
    end
  end

  def purchase_confirmation 
    if current_user.id == Item.find(params[:id]).user_id
      redirect_to item_path(params[:id])
    elsif Item.find(params[:id]).buyer_id.present?
      redirect_to item_path(params[:id])
    else
      @item = Item.find(params[:id])
      card = current_user.cards.first
      @shipping_data = current_user.buyer_shipping_data
      if card.blank?
        redirect_to new_for_purchase_card_path(@item.id)
        flash[:alert] = '購入にはクレジットカード登録が必要です'
        return
      elsif @shipping_data.blank?
        redirect_to new_shipping_data_path
        flash[:alert] = '購入には送付先情報の登録が必要です'
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
  end

  def create_favorite
    favorite = Favorite.new(item_id: params[:id], user_id: current_user.id)
    if favorite.save
    else
      redirect_to item_path(params[:id])
    end
  end

  def destroy_favorite
    favorite = Favorite.find_by(item_id: params[:id], user_id: current_user.id)
    if favorite.destroy
    else
      redirect_to item_path(params[:id])
    end
  end

  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:price,:buyer_id,
    :category_id, brand_attributes: [:id ,:name],shipping_attributes:[:id,:burden, :shipping_way, :area, :day],
    images_attributes:[:id,:image])
    .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end