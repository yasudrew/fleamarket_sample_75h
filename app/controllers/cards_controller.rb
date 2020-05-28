class CardsController < ApplicationController

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    customer = Payjp::Customer.create(
      card: params[:card_token],
      metadata: {user_id: current_user.id}
    )
    
    @card = Card.new(
      card_id: customer.default_card,
      customer_id: customer.id,
      user_id: current_user.id
    )
    @card.save
  end

  # def delete
  #   card = Card.where(user_id: current_user.id).first
  #   if card.exists?
  #     Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     customer.delete
  #     card.delete
  #   end

  #   redirect_to action: "new"
  # end


  def check_phenomenon
    
  end
end