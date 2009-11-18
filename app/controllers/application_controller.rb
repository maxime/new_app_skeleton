class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_current_user

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  layout 'application'

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      flash[:notice] = t('you_must_be_logged_in_to_access_this_page')
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = t('you_must_be_logged_out_to_access_this_page')
      redirect_to home_url
      return false
    end
  end

  def set_current_user
    User.current_user = current_user if current_user
  end
end
