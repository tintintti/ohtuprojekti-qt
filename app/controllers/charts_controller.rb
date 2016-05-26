class ChartsController < ApplicationController
  def index
  end

  def view
    @postcounts = UserHandler.user_postcounts
    @emails = UserHandler.user_emails
  end

end
