class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in

  def authors
    render "test/authors"
  end

  def index
    render "test/index"
  end

  def activity
    render "test/activity"
  end

  def files
    render "test/files"
  end

  def lines
    render "test/lines"
  end

  def tags
    render "test/tags"
  end

  def logged_in
    return session[0]
  end

  def ensure_that_logged_in
    redirect_to login_path, alert:'Et ole kirjautunut sisään.' unless logged_in
  end

end
