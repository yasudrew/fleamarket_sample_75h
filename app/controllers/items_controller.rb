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
    @item = Item.includes(:images).find(params[:id])
    @category = @item.category
    @children = @category.parent
    @parent = @children.parent
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
    if @item.save
      redirect_to root_path
      flash[:notice] = '出品ありがとうございます。下部の商品一覧よりご確認ください。'
    else
      redirect_to new_item_path
      flash[:alert] = '商品の出品に失敗しました。お手数ですが、もう一度やり直してください。'
    end
  end

  def purchase_confirmation
    render layout: 'sub_application'
  end
  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:price,:fee,:profit,:buyer_id,
    :category_id, brand_attributes: [:id ,:name],shipping_attributes:[:id,:burden, :method, :area, :day],
    images_attributes:[:id,:image])
    .merge(user_id: current_user.id)
  end
end
