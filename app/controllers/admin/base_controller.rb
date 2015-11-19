class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  
  private

  def is_admin?
    flash[:error] = "user_not_authorized"
    redirect_to root_path if !current_user.has_role? "admin"
  end
end
