class ApplicationController < ActionController::Base
  before_action :set_locale

  def change_language
    locale = params[:locale]
    I18n.locale = locale
    session[:locale] = locale
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
