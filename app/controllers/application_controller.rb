class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in

  def logged_in
    return session[0]
  end

  def ensure_that_logged_in
    redirect_to login_path, alert:'You must log in first.' unless logged_in
  end

end
