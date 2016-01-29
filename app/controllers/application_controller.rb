class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    User.find_by_session_token(session[:token])
    # fail
  end

  def logged_in?
    return true if current_user
    false
  end

  def log_in_user!(user)
    user.reset_session_token!
  end
end
