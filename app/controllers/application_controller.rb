class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
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

end
