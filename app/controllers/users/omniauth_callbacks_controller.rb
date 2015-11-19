class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    authorize_from_omniauth
  end

  private

  def authorize_from_omniauth
    binding.pry
    user = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
  end
end
