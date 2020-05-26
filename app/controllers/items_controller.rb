class ItemsController < ApplicationController
  def index
  end

  def new
    render layout: 'sub_application'
  end

  def show
    # @item = Item.find(params[:id])
  end

  def purchase_confirmation
    render layout: 'sub_application'
  end
end
