class ShippingDatasController < ApplicationController
  def new
    if current_user.buyer_shipping_data.present?
      redirect_to user_path(current_user.id) 
      flash[:alert]= '送付先情報はすでに登録されています'
    else
      @buyer_shipping_data = BuyerShippingData.new
    end
  end

  def step1
    @buyer_shipping_data = BuyerShippingData.new
  end

  def step2
    session[:family_name] = profile_params[:family_name]
    session[:first_name] = profile_params[:first_name]
    session[:family_name_kana] = profile_params[:family_name_kana]
    session[:first_name_kana] = profile_params[:first_name_kana]
    @buyer_shipping_data = BuyerShippingData.new
  end

  def create 
    @buyer_shipping_data = BuyerShippingData.new(
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_name_kana: session[:family_name_kana],
      first_name_kana: session[:first_name_kana],
      post_code: profile_params[:post_code].gsub(/-/,""),
      prefecture: profile_params[:prefecture],
      city: profile_params[:city],
      address: profile_params[:address],
      building_name: profile_params[:building_name],
      user_id: profile_params[:user_id]
    )
    if @buyer_shipping_data.save
      redirect_to user_path(current_user.id)
      flash[:notice]='送付先情報の登録が完了しました'
    else
      render 'shipping_datas/step1'
    end
  end

  private

  def profile_params
    params.require(:buyer_shipping_data).permit(
      :family_name,
      :first_name,
      :family_name_kana,
      :first_name_kana,
      :post_code,
      :prefecture,
      :city,
      :address,
      :building_name,
    ).merge(user_id: current_user.id)
  end
end
