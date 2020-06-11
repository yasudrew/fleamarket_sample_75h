class ProfilesController < ApplicationController

  def new
    if current_user.profile.present?
      redirect_to user_path(current_user.id) 
      flash[:alert]= '本人確認情報はすでに登録されています'
    else
      @profile = Profile.new
    end
  end

  def step1
    @profile = Profile.new
  end

  def step2
    session[:family_name] = profile_params[:family_name]
    session[:first_name] = profile_params[:first_name]
    session[:family_name_kana] = profile_params[:family_name_kana]
    session[:first_name_kana] = profile_params[:first_name_kana]
    session[:birth_day] = profile_params[:birth_day]
    @profile = Profile.new
  end

  def create 
    @profile = Profile.new(
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_name_kana: session[:family_name_kana],
      first_name_kana: session[:first_name_kana],
      birth_day: session[:birth_day],
      post_code: profile_params[:post_code],
      prefecture: profile_params[:prefecture],
      city: profile_params[:city],
      address: profile_params[:address],
      building_name: profile_params[:building_name],
      user_id: profile_params[:user_id]
    )
    if @profile.save
      redirect_to user_path(current_user.id)
      flash[:notice]='本人確認情報の登録が完了しました'
    else
      render 'profiles/step1'
    end
  end

  private

    def profile_params
      params.require(:profile).permit(
        :family_name,
        :first_name,
        :family_name_kana,
        :first_name_kana,
        :birth_day,
        :post_code,
        :prefecture,
        :city,
        :address,
        :building_name,
      ).merge(user_id: current_user.id)
    end
end
