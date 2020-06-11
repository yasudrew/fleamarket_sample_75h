class CardsController < ApplicationController
  
  # before_action :set_card, except:[:create, :create_for_purchase]

  def new
    card = current_user.cards.first
    redirect_to card_path(current_user.id) if card.present?
  end

  def new_for_purchase
    card = current_user.cards.first
    @item_id = params[:id] 
    redirect_to card_path(current_user.id) if card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
    )
    
    @card = Card.new(
      card_id: customer.default_card,
      customer_id: customer.id,
      user_id: current_user.id
    )
    if @card.save
      redirect_to action: :new
    else
      flash.now[:alert] = '登録に失敗しました。お手数ですが、もう一度やり直してください。'
      render :new
      return
    end
  end

  def create_for_purchase
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
    )
    
    @card = Card.new(
      card_id: customer.default_card,
      customer_id: customer.id,
      user_id: current_user.id
    )
    if @card.save
      redirect_to purchase_confirmation_item_path(params[:id])
    else
      flash.now[:alert] = '登録に失敗しました。お手数ですが、もう一度やり直してください。'
      render :new_for_purchase
      return
    end
  end

  def show
    card = current_user.cards.first
    if card.blank?
      redirect_to action: :new
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
  end

  def delete
    card = current_user.cards.first
    if card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end

    redirect_to action: :new
  end

  def purchase
    if current_user.id == Item.find(params[:id]).user_id
      redirect_to root_path 
    elsif Item.find(params[:id]).buyer_id.present?
      redirect_to root_path
    else
      card = current_user.cards.first
      if card.blank?
        redirect_to action: :new
        flash[:alert] = '購入にはクレジットカード登録が必要です'
      else
        @item = Item.find(params[:id])
        Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
        Payjp::Charge.create(
        amount: @item.price,
        customer: card.customer_id,
        currency: 'jpy'
        )
        if @item.update(buyer_id: current_user.id)
          redirect_to controller: :items, action: :show
          flash[:notice] = 'お買い上げいただき誠にありがとうございます。'
        else
          redirect_to controller: :items, action: :show
          flash[:alert] = '購入に失敗しました。お手数ですが、もう一度やり直してください。'
        end
      end
    end
  end

  private
  def set_card
    card = current_user.cards.first
  end

end
