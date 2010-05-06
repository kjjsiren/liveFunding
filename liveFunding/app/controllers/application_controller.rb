# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
   filter_parameter_logging :password

  include UserAuthentication # /lib/user_authentication.rb
  
  before_filter :set_locale
  before_filter :is_authenticated?
  
  protected
   
  # Judge if the user is logged in
  def is_authenticated?
    if logged_in?
      return true
    else
      @user = User.new
    end
  end
  
  #Changes the language used in the views.
  def set_locale
    #Get the locale from the session, set to default if not available:
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale
    
    locale_path = "#{LOCALES_DIRECTORY}#{I18n.locale}.yml"
    
    #Load the locale file, if not loaded already:
    unless I18n.load_path.include? locale_path
      I18n.load_path << locale_path
      I18n.backend.send(:init_translations)
    end
  
  #Log the errors and notify the user if translation is not available:  
  rescue Exception => err
    logger.error err
    flash.now[:notice] = "#{I18n.locale} translation not available"
    
    I18n.load_path -= [locale_path]
    I18n.locale = session[:locale] = I18n.default_locale
  end    
end
