class Users::ConfirmationsController < Devise::ConfirmationsController
  # After email confirmation, prompt sign-in, then ApplicationController will redirect to edit profile
  protected

  def after_confirmation_path_for(resource_name, resource)
    new_session_path(resource_name)
  end
end
