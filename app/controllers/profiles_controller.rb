class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

  def show
  end

  def by_username
    user = User.friendly.find(params[:username])
    @profile = user.profile || Profile.create!(user: user)
    render :show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profil mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def authorize_owner!
    return unless %i[edit update].include?(action_name.to_sym)
    unless @profile.user == current_user
      redirect_to @profile, alert: "Vous ne pouvez pas modifier ce profil."
    end
  end

  def profile_params
    params.require(:profile).permit(
      :age_f, :age_h, :cheveux_f, :cheveux_h, :description, :fumeur_f, :fumeur_h,
      :origine_f, :origine_h, :pilosite_f, :pilosite_h, :poids_f, :poids_h, :prep_f,
      :prep_h, :profession_f, :profession_h, :signe_f, :signe_h, :silouhette_f,
      :silouhette_h, :taille_f, :taille_h, :tendance_f, :tendance_h, :type_user,
      :yeux_f, :yeux_h, :photo
    )
  end
end
