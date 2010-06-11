# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  USER_NAME, PASSWORD = "tyler", "mr.c00l"

  before_filter :authenticate
  include Authentication
  helper :all
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  require "prawn/measurement_extensions"
  prawnto :prawn => {
              :left_margin => 8.mm,
              :right_margin => 8.mm,
              :top_margin => 5.mm,
              :bottom_margin => 5.mm}
  def page
    [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end

