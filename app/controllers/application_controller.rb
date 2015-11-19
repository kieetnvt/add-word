class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cache
  before_action :get_langs

  rescue_from RuntimeError do |exception|
    flash.now[:error] = exception.message
    render file: 'public/500.html', status: 500, layout: false
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :nickname, :current_password) }
  end

  def user_not_authorized
    flash[:error] = "user_not_authorized"
    redirect_to root_path
  end

  def record_not_found
    render text: "record_not_found"
  end

  def set_cache
    $cache = ActiveSupport::Cache::FileStore.new("/tmp/cache", expires_in: 10.days)
  end

  def get_langs
    if $cache.read(:languages).present?
      $cache.read(:languages)
    else
      $cache.write(:languages, Yandex::API.new.get_langs)
      $cache.read(:languages)
    end
  end
end
