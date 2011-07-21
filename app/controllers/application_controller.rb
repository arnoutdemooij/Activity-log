class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to new_session_path, :notice => "Please log in"
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

