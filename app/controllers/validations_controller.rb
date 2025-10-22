class ValidationsController < ApplicationController
  protect_from_forgery with: :null_session

  def username
    value = params[:value].to_s.strip
    taken = value.blank? || User.where('LOWER(username) = ?', value.downcase).exists?
    render json: { available: !taken }
  end

  def email
    value = params[:value].to_s.strip
    taken = value.blank? || User.where('LOWER(email) = ?', value.downcase).exists?
    render json: { available: !taken }
  end
end
