class CardsController < ApplicationController

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
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
      render :show
      return
    end
  end

  def show
    card = Card.where(user_id: current_user.id).first
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
    card = Card.where(user_id: current_user.id).first
    if card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end

    redirect_to action: :new
  end

end
